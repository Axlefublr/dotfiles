export def 'diff files' [file1: path, file2: path] {
	open $file1 | to json | jq -S . | save -f /tmp/mine/file1
	open $file2 | to json | jq -S . | save -f /tmp/mine/file2
	footclient -HN fish -c 'dof /tmp/mine/file1 /tmp/mine/file2'
}

export def record [against: record]: record -> table<op: string, path: cell-path> {
  let a = $in
  let b = $against

  let a_keys = $a | columns
  let b_keys = $b | columns

  let root_removals = $a_keys | where $it not-in $b_keys | wrap-changes '-' []
  let root_additions = $b_keys | where $it not-in $a_keys | wrap-changes '+' []
  let root_common = $a_keys | where $it in $b_keys

  if $root_common == [] {
    $root_removals ++ $root_additions
  } else {
    let root_length = $root_common | length

    let initial = { pointer: [] crumbs: [{ index: 0 length: $root_length keys: $root_common }] }
    generate {|path|
      # pointers are ensured to exist for both records
      let pointer = $path.pointer
      let pointer_cell_path = $pointer | into cell-path
      let crumbs = $path.crumbs

      let a_value_here = $a | get $pointer_cell_path
      let b_value_here = $b | get $pointer_cell_path

      if $a_value_here == $b_value_here {
        continue-traversal $pointer $crumbs
      } else {
        let a_type_here = $a_value_here | describe --detailed | get type
        let b_type_here = $b_value_here | describe --detailed | get type
        if $a_type_here == record and $b_type_here == record {
          let a_keys_here = $a_value_here | columns
          let b_keys_here = $b_value_here | columns

          let removals = $a_keys_here | where $it not-in $b_keys_here | wrap-changes '-' $pointer
          let additions = $b_keys_here | where $it not-in $a_keys_here | wrap-changes '+' $pointer
          let common = $a_keys_here | where $it in $b_keys_here

          if $common != [] {
            let length = $common | length
            let crumb = { index: 0 length: $length keys: $common }
            let next_pointer = $pointer | append $common.0
            let next_crumbs = $crumbs | append $crumb
            {
              next: { pointer: $next_pointer crumbs: $next_crumbs }
              out: ($removals ++ $additions)
            }
          } else {
            continue-traversal $pointer $crumbs
            | insert out ($removals ++ $additions)
          }
        } else {
          continue-traversal $pointer $crumbs
          | insert out { op: '/' path: $pointer_cell_path }
        }
      }
    } $initial
    | flatten
  }
}

def wrap-changes [op: string base: list<string>] {
  each {|key| { op: $op path: ($base | append $key | into cell-path) } }
}

def continue-traversal [pointer: list<string> crumbs: table<index: int, index: int, keys: list<string>>] {
  let crumb = $crumbs | last
  let next_index = $crumb.index + 1
  if $next_index < $crumb.length {
    # continue at this stage
    let next_key = $crumb.keys | get ($crumb.index + 1)
    let next_pointer = $pointer | drop | append $next_key
    let next_crumb = $crumb | update index $next_index
    let next_crumbs = $crumbs | drop | append $next_crumb
    { next: { pointer: $next_pointer crumbs: $next_crumbs } }
  } else {
    # move up until there is space for another traversal
    $crumbs
    | reverse
    | generate {|crumb levels = 0|
      if ($crumb.index + 1) < $crumb.length {
        { out: ($levels + 1) }
      } else {
        { next: ($levels + 1) }
      }
    }
    | first
    | let levels
    if $levels != null {
      let reverted_pointer = $pointer | drop $levels
      let reverted_crumbs = $crumbs | drop $levels
      let reverted_crumb = $reverted_crumbs | last
      let reverted_next_index = $reverted_crumb.index + 1
      let next_key = $reverted_crumb.keys | get $reverted_next_index
      let next_pointer = $reverted_pointer | drop | append $next_key
      let next_crumb = $reverted_crumb | update index $reverted_next_index
      let next_crumbs = $reverted_crumbs | drop | append $next_crumb
      { next: { pointer: $next_pointer crumbs: $next_crumbs } }
    } else {
      # we have reached the end
      {}
    }
  }
}
