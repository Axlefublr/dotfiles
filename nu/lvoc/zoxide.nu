# customized output of `zoxide init nushell`, similar to how I also handle zoxide for fish, in fish/fun/zoxide.fish

def --env --wrapped __zoxide_z [...rest: string] {
  let path = match $rest {
    [] => {'~'},
    [ '-' ] => {'-'},
    [ $arg ] if ($arg | path expand | path type) == 'dir' => {$arg}
    _ => {
      ^zoxide query --exclude $env.PWD -- ...$rest | str trim -r -c "\n"
    }
  }
  ^zoxide add -- $path
  cd $path
  if ($env.TIT? | is-empty) {
    tit ($path | path shrink | path basename)
  }
}

alias z = __zoxide_z
