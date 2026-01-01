#!/usr/bin/env -S nu -n --no-std-lib

let statusline = {
    separator: ''
    mode: {
        normal: normal
        insert: insert
        select: select
    }
    left: [
        # version-control
        # spacer
        diagnostics
        primary-selection-length
        selections
    ]
    center: [
        read-only-indicator
        file-modification-indicator
    ]
    right: [
        spinner
        register
        position
        position-percentage
        file-encoding
    ],
}

let lsp = {
    # [[sort on]]
    auto-signature-help: false
    display-inlay-hints: false
    display-messages: true
    display-signature-help-docs: true
    goto-reference-include-declaration: false
    snippets: true
    # [[sort off]]
}

let editor = {
    # [[sort on]]
    disable-dot-repeat: true
    should-statusline: false
    show-diagnostics: true
    whichkey: false
    # [[sort off]]
    word-completion: {
        enable: true
        trigger-length: 4
    }
    harp: {
        command: filetype
        search: filetype
        register: filetype
        mark: buffer
    }
    # [[sort on]]
    # idle-timeout: 250
    auto-completion: true
    auto-format: true
    auto-info: true
    auto-save: { focus-lost: false }
    bufferline: always
    color-modes: true
    completion-timeout: 5
    completion-trigger-len: 2
    continue-comments: false
    cursor-shape: { insert: bar }
    default-line-ending: lf
    default-yank-register: +
    insert-final-newline: true
    jump-label-alphabet: jfkdlsieowcmxnzvahgurpq
    line-number: relative
    lsp: $lsp
    preview-completion-insert: true
    scrolloff: 99
    statusline: $statusline
    text-width: 110
    trim-final-newlines: true
    trim-trailing-whitespace: true
    # [[sort off]]
    shell: [
        nu
        --no-std-lib
        --stdin
        --config
        ~/fes/dot/nu/lvoc/crooked.nu
        -c
    ]
    soft-wrap: {
        enable: true
        max-wrap: 0
        wrap-indicator: ''
    }
    whitespace: {
        render: {
            # newline: all
            # tab: all
        }
        characters: {
            newline: ↪
            space: ·
            nbsp: ⍽
            nnbsp: ␣
            tab: ➜
            tabpad: ' '
        }
    }
    auto-pairs: {
        '<': '>'
        '(': ')'
        '{': '}'
        '[': ']'
        '"': '"'
        "'": "'"
        '`': '`'
        '«': '»'
        '‘': '’'
        '“': '”'
    }
    gutters: {
        line-numbers: { min-width: 2 }
        layout: [
            # diff
        ]
    }
    gutters-right: {
        layout: [
            scrollbar
        ]
    }
    file-picker: {
        hidden: false  # also shows "dot files" in results
    }
    inline-diagnostics: {
        cursor-line: info
        other-lines: info
        max-wrap: 0
    }
}

let all_modes_mappings = {
    # [[sort on]]
    A-F11: goto_previous_buffer
    A-F12: goto_next_buffer
    A-ins: ':quit!'
    C-6: ':buffer-close!'
    C-down: copy_selection_on_next_line
    C-e: ':new'
    C-end: move_parent_node_end
    C-home: move_parent_node_start
    C-i: [commit_undo_checkpoint, normal_mode, open_above]
    C-o: [commit_undo_checkpoint, normal_mode, open_below]
    C-pagedown: goto_next_buffer
    C-pageup: goto_previous_buffer
    C-s: signature_help
    C-t: ':reload!'
    C-tab: add_newline_above
    C-up: copy_selection_on_prev_line
    F12: add_newline_below
    S-down: move_lines_down
    S-home: ':buffer-close!'
    S-left: unindent
    S-right: indent
    S-up: move_lines_up
    # [[sort off]]
    F2: [
        ":noop %sh(hx-blammo '%(full_path)' '%(relative_path)' '%(buffer_parent)' '%(selection)')"
        ':sh footclient -ND %(current_working_directory) o+e>| ignore'
    ]
    F5: [
        ":noop %sh(hx-blammo '%(full_path)' '%(relative_path)' '%(buffer_parent)' '%(selection)')"
        ':sh footclient -T floating -ND %(current_working_directory) o+e>| ignore'
    ]
    S-F2: [
        ":noop %sh(hx-blammo '%(full_path)' '%(relative_path)' '%(buffer_parent)' '%(selection)')"
        ':sh footclient -ND %(buffer_parent) o+e>| ignore'
    ]
    S-F5: [
        ":noop %sh(hx-blammo '%(full_path)' '%(relative_path)' '%(buffer_parent)' '%(selection)')"
        ':sh footclient -T floating -ND %(buffer_parent) o+e>| ignore'
    ]
    C-z: [
        ":noop %sh(echo '%(current_working_directory)' >~/.cache/mine/helix-cwd-suspend)"
        ":noop %sh(echo '%(buffer_parent)' >~/.cache/mine/helix-buffer-head-suspend)"
        ':write-all'
        'suspend'
    ]
    F6: [
        ':sh rm -f /tmp/mine/yazi-chooser-file'
        ':noop %sh(footclient yazi %{full_path} --chooser-file=/tmp/mine/yazi-chooser-file)'
        ':open %sh{cat /tmp/mine/yazi-chooser-file}'
        ':reload-all'
    ]
    F3: [
        ':sh rm -f /tmp/mine/yazi-chooser-file'
        ':noop %sh(footclient yazi --chooser-file=/tmp/mine/yazi-chooser-file)'
        ':open %sh{cat /tmp/mine/yazi-chooser-file}'
        ':reload-all'
    ]
}

let normal_select_mappings = {
    # [[sort on]]
    "'": [':write-all', ':reload-all']
    '!': keep_primary_selection
    '"': ':write!'
    '#': yank_joined
    '$': remove_selections
    '%': [save_selection, select_all]
    '&': '@<A-k>r—<ret>×<A-k>M'
    '(': goto_prev_change
    ')': goto_next_change
    '*': [search_selection_detect_word_boundaries, normal_mode]
    '+': rotate_selections_forward
    '-': rotate_selections_backward
    '.': toggle_line_select
    '0': ':buffer-nth -r 1'
    '1': ':buffer-nth 1'
    '2': ':buffer-nth 2'
    '3': ':buffer-nth 3'
    '4': ':buffer-nth 4'
    '5': ':buffer-nth 5'
    '6': ':buffer-nth 6'
    '7': ':buffer-nth 7'
    '8': ':buffer-nth 8'
    '9': ':buffer-nth 9'
    ':': ':write-quit-all'
    '=': remove_primary_selection
    '@': toggle_comments
    '[': shell_insert_output
    '\\': ':sort'
    ']': shell_append_output
    '^': make_search_word_bounded
    '_': switch_to_lowercase
    '`': switch_case
    '{': rotate_selections_first
    '|': shell_pipe
    '}': rotate_selections_last
    '¢': ":pipe $in | if ($in | str substring 0..0) == '-' { str trim -c '-' } else { fill -w 44 -a center -c '-' }"
    '°': shell_pipe_to
    '×': align_selections
    '÷': select_references_to_symbol_under_cursor
    '‘': rotate_selection_contents_backward
    '’': rotate_selection_contents_forward
    '‚': reverse_selection_contents
    '“': goto_prev_diag
    '”': goto_next_diag
    '…': split_selection_on_newline
    '€': keep_selections
    '↑': ':tree-sitter-highlight-name'
    '↓': ':tree-sitter-subtree'
    '✅': ':pipe `"✅"`'
    '❌': ':pipe `"❌"`'
    '❓': ':pipe `"❓"`'
    '❗': ':pipe `"❗"`'
    '🚀': rename_symbol
    A-N: extend_search_prev
    A-i: jump_forward
    A-j: trim_selections
    A-k: extend_to_line_bounds
    A-l: shrink_to_line_bounds
    A-n: extend_search_next
    A-o: jump_backward
    B: [add_newline_above, move_line_up, paste_before]
    C-/: select_first_and_last_chars
    C-a: decrement
    C-c: change_selection_noyank
    C-d: delete_selection_noyank
    C-f: increment
    C-h: select_prev_sibling
    C-j: shrink_selection
    C-k: [expand_selection, ensure_selections_forward, flip_selections]
    C-l: select_next_sibling
    C-m: merge_consecutive_selections
    C-n: select_all_siblings
    C-q: ':cd ..'
    C-r: ':reload!'
    C-u: select_all_children
    C-v: ensure_selections_forward
    C-w: ':write-buffer-close'
    C-x: join_selections
    C: ':pipe (char space) + $in'
    D: ':pipe str trim'
    I: insert_at_line_start
    M: merge_selections
    N: search_prev
    O: paste_before
    R: split_selection
    S-pagedown: goto_next_paragraph
    S-pageup: goto_prev_paragraph
    S: hover
    T: redo
    U: insert_at_line_end
    V: '@u <esc>'
    W: repeat_last_motion
    X: join_selections_space
    Z: '@c<ret><esc>'
    b: [add_newline_below, move_line_down, paste_before]
    c: change_selection
    d: delete_selection
    esc: collapse_selection
    i: insert_mode
    n: search_next
    o: paste_after
    p: select_register
    pagedown: page_cursor_half_down
    pageup: page_cursor_half_up
    q: goto_word
    r: select_regex
    ret: command_mode
    s: yank
    t: undo
    tab: ':edit %sh(open ~/.cache/mine/shell-cwd)'
    u: append_mode_same_line
    v: flip_selections
    w: replace_with_yanked
    # [[sort off]]
    A-.: {
        T: [save_selection, goto_next_test]
        e: [save_selection, goto_next_entry]
        c: [save_selection, goto_next_comment]
        f: [save_selection, goto_next_function]
        a: [save_selection, goto_next_parameter]
        t: [save_selection, goto_next_class]
        g: [save_selection, goto_last_change]
        d: [save_selection, goto_last_diag]
    }
    A-,: {
        T: [save_selection, goto_prev_test]
        e: [save_selection, goto_prev_entry]
        c: [save_selection, goto_prev_comment]
        f: [save_selection, goto_prev_function]
        a: [save_selection, goto_prev_parameter]
        t: [save_selection, goto_prev_class]
        g: [save_selection, goto_first_change]
        d: [save_selection, goto_first_diag]
    }
    m: {
        # [[sort on]]
        "'": ':toggle whichkey'
        ';': ':toggle soft-wrap.enable'
        C: ':echopy %(relative_path)'
        M: ':sh chmod +x %(full_path)'
        V: ':echopy %sh(ghl -pb HEAD %(relative_path))'
        Z: ':echopy %sh(ghl)'
        a: [save_selection, select_textobject_around]
        c: ':echopy %(full_path)'
        f: [save_selection, select_textobject_inner]
        i: count_selections
        k: ':toggle show-diagnostics'
        l: ':toggle lsp.display-inlay-hints'
        o: ':toggle auto-format'
        p: ':toggle should-statusline'
        v: ':echopy %sh(ghl %(relative_path))'
        x: surround_replace
        z: ':echopy %(current_working_directory)'
        # [[sort off]]
        t: {
            k: ':pipe fish -c "mst kbd"'
            b: ':pipe fish -c "mst b"'
            h: ':pipe fish -c "mst h"'
            d: ':pipe fish -c "mst div"'
            c: ':pipe fish -c "mst cd"'
            o: ':pipe fish -c "mst o"'
            i: ':pipe fish -c "mst i"'
            t: surround_add_tag
        }
        w: {
            '(': ':pipe strip-wrapper-type.rs b'
            '{': ':pipe strip-wrapper-type.rs B'
            '[': ':pipe strip-wrapper-type.rs s'
            '<': ':pipe strip-wrapper-type.rs t'
            '|': ':pipe strip-wrapper-type.rs p'
        }
        e: {
            '(': ':pipe wrap-in-block.rs b'
            '{': ':pipe wrap-in-block.rs B'
            '[': ':pipe wrap-in-block.rs s'
            '<': ':pipe wrap-in-block.rs t'
            '|': ':pipe wrap-in-block.rs p'
            '`': ':pipe wrap-in-block.rs "`"'
            'e': ':pipe wrap-in-block.rs begin'
            '"': ':pipe wrap-in-block.rs `"`'
        }
    }
    space: {
        # [[sort on]]
        D: diagnostics_picker
        J: command_palette
        d: local_search_fuzzy
        e: buffer_picker
        f: file_picker_in_current_directory
        j: file_picker_in_current_buffer_directory
        k: global_search
        l: symbol_picker
        s: syntax_symbol_picker
        # [[sort off]]
    }
    ';': {
        a: harp_command
        d: $magazine_openers
        e: harp_search
        r: harp_relative_file
        s: harp_file
        w: harp_register
        f: harp_mark
    }
    g: {
        # [[sort on]]
        F: ':edit %sh(wl-paste)'
        Q: ':cd %(buffer_parent)'
        a: ':buffer-close-all'
        d: ':buffer-close-others'
        g: ':reset-diff-change'
        m: goto_last_accessed_file
        q: ":cd %sh(git -C '%(buffer_parent)' rev-parse --show-toplevel)"
        r: ':lsp-restart'
        # [[sort off]]
    }
    z: {
        # [[sort on]]
        I: goto_implementation
        J: goto_declaration
        c: ':pipe ~/fes/dot/eli/fool/qalc.fish -t $in'
        i: goto_type_definition
        j: goto_definition
        k: goto_reference
        o: code_action
        z: [':write-all', ':noop %sh{python ~/fes/dot/helix/generator.py}', ':config-reload']
        # [[sort off]]
    }

}

let normal_insert_mappings = {}

let normal_mappings = {
}

let select_mappings = {
}

let insert_mappings = {
}

let mappings = {
    normal: ($all_modes_mappings | merge deep $normal_select_mappings | merge deep $normal_insert_mappings | merge deep $normal_mappings)
    select: ($all_modes_mappings | merge deep $normal_select_mappings | merge deep $select_mappings)
    insert: ($all_modes_mappings | merge deep $normal_insert_mappings | merge deep $insert_mappings)
}

let entire_config = {
    theme: gruvbox_material
    editor: $editor
    keys: $mappings
}

$entire_config
