#!/usr/bin/env python3

import copy
from typing import Any

import toml
from magazine_openers import magazine_openers
from russian_dict import russian_dict

statusline: dict[str, Any] = {
    'separator': '',
    'mode': {
        'normal': 'normal',
        'insert': 'insert',
        'select': 'select',
    },
    'left': [
        # 'version-control',
        # 'spacer',
        'diagnostics',
        'primary-selection-length',
        'selections',
    ],
    'center': [
        'read-only-indicator',
        'file-modification-indicator',
    ],
    'right': [
        'spinner',
        'register',
        'position',
        'position-percentage',
        'file-encoding',
    ],
}

lsp: dict[str, Any] = {
    # [[sort on]]
    'auto-signature-help': False,
    'display-inlay-hints': False,
    'display-messages': True,
    'display-signature-help-docs': True,
    'goto-reference-include-declaration': False,
    'snippets': True,
    # [[sort off]]
}

editor: dict[str, Any] = {
    # [[sort on]]
    'disable-dot-repeat': True,
    'should-statusline': False,
    'show-diagnostics': True,
    'whichkey': False,
    # [[sort off]]
    'word-completion': {
        'enable': True,
        'trigger-length': 4,
    },
    'harp': {
        'command': 'filetype',
        'search': 'buffer',
        'register': 'filetype',
        'mark': 'buffer',
    },
    # [[sort on]]
    # 'idle-timeout': 250,
    'auto-completion': True,
    'auto-format': True,
    'auto-info': True,
    'auto-save': {'focus-lost': False},
    'bufferline': 'always',
    'color-modes': True,
    'completion-timeout': 5,
    'completion-trigger-len': 2,
    'continue-comments': False,
    'cursor-shape': {'insert': 'bar'},
    'default-line-ending': 'lf',
    'default-yank-register': '+',
    'insert-final-newline': True,
    'jump-label-alphabet': 'jfkdlsieowcmxnzvahgurpq',
    'line-number': 'relative',
    'lsp': lsp,
    'preview-completion-insert': True,
    'scrolloff': 99,
    'statusline': statusline,
    'text-width': 110,
    'trim-final-newlines': True,
    'trim-trailing-whitespace': True,
    # [[sort off]]
    'shell': [
        'nu',
        '--no-std-lib',
        '--stdin',
        '--config',
        '~/fes/dot/nu/lvoc/crooked.nu',
        '-c',
    ],
    'soft-wrap': {
        'enable': True,
        'max-wrap': 0,
        'wrap-indicator': '',
    },
    'whitespace': {
        'render': {
            # 'newline': 'all',
            # 'tab': 'all',
        },
        'characters': {
            'newline': '↪',
            'space': '·',
            'nbsp': '⍽',
            'nnbsp': '␣',
            'tab': '➜',
            'tabpad': ' ',
        },
    },
    'auto-pairs': {
        '<': '>',
        '(': ')',
        '{': '}',
        '[': ']',
        '"': '"',
        "'": "'",
        '`': '`',
        '«': '»',
        '‘': '’',
        '“': '”',
    },
    'gutters': {
        'line-numbers': {'min-width': 2},
        'layout': [
            # 'diff',
        ],
    },
    'gutters-right': {
        'layout': [
            'scrollbar',
        ],
    },
    'file-picker': {
        'hidden': False,  # also shows "dot files" in results
    },
    'inline-diagnostics': {
        'cursor-line': 'info',
        'other-lines': 'info',
        'max-wrap': 0,
    },
}


def disable(mappings: list[str]) -> dict[str, str]:
    return {item: 'no_op' for item in mappings}


def transform(char: str):
    new_key = russian_dict.get(char)
    if new_key is not None:
        return new_key
    if char.startswith('A-') or char.startswith('C-'):
        subkey = russian_dict.get(char[2:])
        if subkey is not None:
            return char[:2] + subkey


def deep_merge(a: dict[str, Any], b: dict[str, Any]) -> dict[str, Any]:
    result: dict[str, Any] = copy.deepcopy(a)
    for key, val in b.items():
        if key in result and isinstance(result[key], dict) and isinstance(val, dict):
            result[key] = deep_merge(result[key], val)
        else:
            result[key] = copy.deepcopy(val)
    return result


def rusify(english_dict: dict[str, Any]) -> dict[str, Any]:
    russian_dict = {}
    for key, value in english_dict.items():
        russian_dict[key] = value
        russian_key = transform(key)
        if russian_key is None:
            # sys.stderr.write(f"I don't know {key}\n")
            continue
        if isinstance(value, dict):
            russian_dict[russian_key] = rusify(value)
        else:
            russian_dict[russian_key] = value
    return russian_dict


all_modes_mappings: dict[str, Any] = {
    # [[sort on]]
    'A-F11': 'goto_previous_buffer',
    'A-F12': 'goto_next_buffer',
    'A-ins': ':quit!',
    'C-A-w': ':buffer-close!',
    'C-down': 'copy_selection_on_next_line',
    'C-e': ':new',
    'C-end': 'move_parent_node_end',
    'C-home': 'move_parent_node_start',
    'C-i': ['commit_undo_checkpoint', 'normal_mode', 'open_above'],
    'C-o': ['commit_undo_checkpoint', 'normal_mode', 'open_below'],
    'C-pagedown': 'goto_next_buffer',
    'C-pageup': 'goto_previous_buffer',
    'C-s': 'signature_help',
    'C-t': ':reload!',
    'C-tab': 'add_newline_above',
    'C-up': 'copy_selection_on_prev_line',
    'F12': 'add_newline_below',
    'S-down': 'move_lines_down',
    'S-home': ':buffer-close!',
    'S-left': 'unindent',
    'S-right': 'indent',
    'S-up': 'move_lines_up',
    # [[sort off]]
    'F2': [
        ":noop %sh(hx-blammo '%(full_path)' '%(relative_path)' '%(buffer_parent)' '%(selection)')",
        ':sh footclient -ND %(current_working_directory) o+e>| ignore',
    ],
    'F5': [
        ":noop %sh(hx-blammo '%(full_path)' '%(relative_path)' '%(buffer_parent)' '%(selection)')",
        ':sh footclient -T floating -ND %(current_working_directory) o+e>| ignore',
    ],
    'S-F2': [
        ":noop %sh(hx-blammo '%(full_path)' '%(relative_path)' '%(buffer_parent)' '%(selection)')",
        ':sh footclient -ND %(buffer_parent) o+e>| ignore',
    ],
    'S-F5': [
        ":noop %sh(hx-blammo '%(full_path)' '%(relative_path)' '%(buffer_parent)' '%(selection)')",
        ':sh footclient -T floating -ND %(buffer_parent) o+e>| ignore',
    ],
    'C-z': [
        ":noop %sh(echo '%(current_working_directory)' >~/.cache/mine/helix-cwd-suspend)",
        ":noop %sh(echo '%(buffer_parent)' >~/.cache/mine/helix-buffer-head-suspend)",
        ':write-all',
        'suspend',
    ],
    'F6': [
        ':sh rm -f /tmp/mine/yazi-chooser-file',
        ':noop %sh(footclient yazi %{full_path} --chooser-file=/tmp/mine/yazi-chooser-file)',
        ':open %sh{cat /tmp/mine/yazi-chooser-file}',
        ':reload-all',
    ],
    'F3': [
        ':sh rm -f /tmp/mine/yazi-chooser-file',
        ':noop %sh(footclient yazi --chooser-file=/tmp/mine/yazi-chooser-file)',
        ':open %sh{cat /tmp/mine/yazi-chooser-file}',
        ':reload-all',
    ],
}

normal_select_mappings: dict[str, Any] = {
    **disable(
        [
            # [[sort on]]
            'B',
            'P',
            'R',
            'Y',
            'b',
            'p',
            'y',
            # [[sort off]]
        ]
    ),
    # [[sort on]]
    "'": [':write-all', ':reload-all'],
    '!': 'keep_primary_selection',
    '"': ':write!',
    '#': 'yank_joined',
    '$': 'remove_selections',
    '%': ['save_selection', 'select_all'],
    '&': '@<A-k>r—<ret>×<A-k>M',
    '(': 'goto_prev_change',
    ')': 'goto_next_change',
    '*': ['search_selection_detect_word_boundaries', 'normal_mode'],
    '+': 'rotate_selections_forward',
    '-': 'rotate_selections_backward',
    '.': 'toggle_line_select',
    '0': ':buffer-nth -r 1',
    '1': ':buffer-nth 1',
    '2': ':buffer-nth 2',
    '3': ':buffer-nth 3',
    '4': ':buffer-nth 4',
    '5': ':buffer-nth 5',
    '6': ':buffer-nth 6',
    '7': ':buffer-nth 7',
    '8': ':buffer-nth 8',
    '9': ':buffer-nth 9',
    ':': ':write-quit-all',
    '=': 'remove_primary_selection',
    '@': 'toggle_comments',
    'A-N': 'extend_search_prev',
    'A-i': 'jump_forward',
    'A-j': 'trim_selections',
    'A-k': 'extend_to_line_bounds',
    'A-l': 'shrink_to_line_bounds',
    'A-n': 'extend_search_next',
    'A-o': 'jump_backward',
    'A-w': ':write-buffer-close',
    'B': ['add_newline_above', 'move_line_up', 'paste_before'],
    'C': ':pipe (char space) + $in',
    'C-/': 'select_first_and_last_chars',
    'C-a': 'decrement',
    'C-c': 'change_selection_noyank',
    'C-d': 'delete_selection_noyank',
    'C-f': 'increment',
    'C-h': 'select_prev_sibling',
    'C-j': 'shrink_selection',
    'C-k': ['expand_selection', 'ensure_selections_forward', 'flip_selections'],
    'C-l': 'select_next_sibling',
    'C-m': 'merge_consecutive_selections',
    'C-n': 'select_all_siblings',
    'C-q': ':cd ..',
    'C-r': ':reload!',
    'C-u': 'select_all_children',
    'C-v': 'ensure_selections_forward',
    'C-x': 'join_selections',
    'D': ':pipe str trim',
    'I': 'insert_at_line_start',
    'M': 'merge_selections',
    'N': 'search_prev',
    'O': 'paste_before',
    'R': 'split_selection',
    'S': 'hover',
    'S-pagedown': 'goto_next_paragraph',
    'S-pageup': 'goto_prev_paragraph',
    'T': 'redo',
    'U': 'insert_at_line_end',
    'V': '@u <esc>',
    'W': 'repeat_last_motion',
    'X': 'join_selections_space',
    'Z': '@c<ret><esc>',
    '[': 'shell_insert_output',
    '\\': ':sort',
    ']': 'shell_append_output',
    '^': 'make_search_word_bounded',
    '_': 'switch_to_lowercase',
    '`': 'switch_case',
    'b': ['add_newline_below', 'move_line_down', 'paste_before'],
    'c': 'change_selection',
    'd': 'delete_selection',
    'esc': 'collapse_selection',
    'i': 'insert_mode',
    'n': 'search_next',
    'o': 'paste_after',
    'p': 'select_register',
    'pagedown': 'page_cursor_half_down',
    'pageup': 'page_cursor_half_up',
    'r': 'select_regex',
    'ret': 'command_mode',
    's': 'yank',
    't': 'undo',
    'tab': ':edit %sh(open ~/.cache/mine/shell-cwd)',
    'u': 'append_mode_same_line',
    'v': 'flip_selections',
    'w': 'replace_with_yanked',
    '{': 'rotate_selections_first',
    '|': 'shell_pipe',
    '}': 'rotate_selections_last',
    '¢': ":pipe $in | if ($in | str substring 0..0) == '-' { str trim -c '-' } else { fill -w 44 -a center -c '-' }",
    '°': 'shell_pipe_to',
    '×': 'align_selections',
    '÷': 'select_references_to_symbol_under_cursor',
    '‘': 'rotate_selection_contents_backward',
    '’': 'rotate_selection_contents_forward',
    '‚': 'reverse_selection_contents',
    '“': 'goto_prev_diag',
    '”': 'goto_next_diag',
    '…': 'split_selection_on_newline',
    '€': 'keep_selections',
    '↑': ':tree-sitter-highlight-name',
    '↓': ':tree-sitter-subtree',
    '✅': ':pipe `"✅"`',
    '❌': ':pipe `"❌"`',
    '❓': ':pipe `"❓"`',
    '❗': ':pipe `"❗"`',
    '🚀': 'rename_symbol',
    # [[sort off]]
    'A-.': {
        'T': 'goto_next_test',
        'e': 'goto_next_entry',
        'c': 'goto_next_comment',
        'f': 'goto_next_function',
        'a': 'goto_next_parameter',
        't': 'goto_next_class',
        'g': 'goto_last_change',
        'd': 'goto_last_diag',
    },
    'A-,': {
        'T': 'goto_prev_test',
        'e': 'goto_prev_entry',
        'c': 'goto_prev_comment',
        'f': 'goto_prev_function',
        'a': 'goto_prev_parameter',
        't': 'goto_prev_class',
        'g': 'goto_first_change',
        'd': 'goto_first_diag',
    },
    'm': {
        # [[sort on]]
        ';': ':toggle whichkey',
        'C': ':echopy %(relative_path)',
        'M': ':sh chmod +x %(full_path)',
        'V': ':echopy %sh(ghl -pb HEAD %(relative_path))',
        'Z': ':echopy %sh(ghl)',
        'a': ['save_selection', 'select_textobject_around'],
        'c': ':echopy %(full_path)',
        'f': ['save_selection', 'select_textobject_inner'],
        'i': ':sh fish -c "append_github_line_numbers %(cursor_line)"',
        'k': ':toggle show-diagnostics',
        'l': ':toggle lsp.display-inlay-hints',
        'n': ':toggle soft-wrap.enable',
        'o': ':toggle auto-format',
        'p': ':toggle should-statusline',
        'v': ':echopy %sh(ghl %(relative_path))',
        'x': 'surround_replace',
        'z': ':echopy %(current_working_directory)',
        # [[sort off]]
        't': {
            'k': ':pipe fish -c "mst kbd"',
            'b': ':pipe fish -c "mst b"',
            'h': ':pipe fish -c "mst h"',
            'd': ':pipe fish -c "mst div"',
            'c': ':pipe fish -c "mst cd"',
            'o': ':pipe fish -c "mst o"',
            'i': ':pipe fish -c "mst i"',
            't': 'surround_add_tag',
        },
        'w': {
            '(': ':pipe strip-wrapper-type.rs b',
            '{': ':pipe strip-wrapper-type.rs B',
            '[': ':pipe strip-wrapper-type.rs s',
            '<': ':pipe strip-wrapper-type.rs t',
            '|': ':pipe strip-wrapper-type.rs p',
        },
        'e': {
            '(': ':pipe wrap-in-block.rs b',
            '{': ':pipe wrap-in-block.rs B',
            '[': ':pipe wrap-in-block.rs s',
            '<': ':pipe wrap-in-block.rs t',
            '|': ':pipe wrap-in-block.rs p',
            '`': ':pipe wrap-in-block.rs "`"',
            'e': ':pipe wrap-in-block.rs begin',
            '"': ':pipe wrap-in-block.rs `"`',
        },
    },
    'x': 'harp_mark',
    'q': 'harp_search',
    ';': 'harp_register',
    'space': {
        **disable(
            [
                # [[sort on]]
                'A-c',
                'D',
                'G',
                'Y',
                'b',
                # [[sort off]]
            ]
        ),
        # [[sort on]]
        'D': 'diagnostics_picker',
        'J': 'command_palette',
        'K': 'syntax_workspace_symbol_picker',
        'L': 'workspace_symbol_picker',
        'a': 'harp_command',
        'd': magazine_openers,
        'e': 'buffer_picker',
        'f': 'file_picker_in_current_directory',
        'i': 'local_search_fuzzy',
        'j': 'file_picker_in_current_buffer_directory',
        'k': 'syntax_symbol_picker',
        'l': 'symbol_picker',
        'r': 'harp_relative_file',
        's': 'harp_file',
        'w': 'global_search',
        # [[sort off]]
    },
    'g': {
        **disable(
            [
                # [[sort on]]
                'D',
                'c',
                'd',
                'r',
                # [[sort off]]
            ]
        ),
        # [[sort on]]
        'F': ':edit %sh(wl-paste)',
        'Q': ':cd %(buffer_parent)',
        'a': ':buffer-close-all',
        'd': ':buffer-close-others',
        'g': ':reset-diff-change',
        'm': 'goto_last_accessed_file',
        'q': ":cd %sh(git -C '%(buffer_parent)' rev-parse --show-toplevel)",
        'r': ':lsp-restart',
        # [[sort off]]
    },
    'z': {
        **disable(
            [
                # [[sort on]]
                'C-b',
                'C-d',
                'C-f',
                'C-u',
                'b',
                'backspace',
                'down',
                'pagedown',
                'pageup',
                'space',
                't',
                'up',
                # [[sort off]]
            ]
        ),
        # [[sort on]]
        'I': 'goto_implementation',
        'J': 'goto_declaration',
        'c': ':pipe ~/fes/dot/eli/fool/qalc.fish -t $in',
        'i': 'goto_type_definition',
        'j': 'goto_definition',
        'k': 'goto_reference',
        'o': 'code_action',
        'z': [':write-all', ':noop %sh{python ~/fes/dot/helix/generator.py}', ':config-reload'],
        # [[sort off]]
    },
}

normal_insert_mappings: dict[str, Any] = {}

normal_mappings: dict[str, Any] = {
    # [[sort on]]
    ',': ['collapse_selection', 'replace'],
    '<': 'find_prev_char',
    '>': 'find_next_char',
    'A-e': ['move_prev_sub_word_start', 'trim_selections'],
    'A-f': ['move_next_sub_word_end', 'trim_selections'],
    'C-,': 'till_prev_char',
    'C-.': 'find_till_char',
    'E': ['move_prev_long_word_start', 'trim_selections'],
    'F': ['move_next_long_word_end', 'trim_selections'],
    'J': ['extend_to_line_bounds', 'extend_line_below'],
    'K': ['extend_to_line_bounds', 'extend_line_above'],
    'a': 'select_mode',
    'e': ['move_prev_word_start', 'trim_selections'],
    'end': ['collapse_selection', 'extend_to_line_end_newline'],
    'f': ['move_next_word_end', 'trim_selections'],
    'h': 'move_char_left',
    'home': ['collapse_selection', 'extend_to_line_start'],
    'j': 'move_visual_line_down',
    'k': 'move_visual_line_up',
    'l': 'move_char_right',
    # [[sort off]]
    'L': [
        'collapse_selection',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
    ],
    'H': [
        'collapse_selection',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
    ],
    'g': {
        # [[sort on]]
        'H': ['collapse_selection', 'extend_to_line_start'],
        'L': ['collapse_selection', 'extend_to_line_end_newline'],
        'h': ['collapse_selection', 'extend_to_first_nonwhitespace'],
        'i': ['collapse_selection', 'extend_to_file_start'],
        'l': ['collapse_selection', 'extend_to_line_end'],
        'o': ['collapse_selection', 'extend_to_file_end'],
        # [[sort off]]
    },
}

select_mappings: dict[str, Any] = {
    # [[sort on]]
    ',': 'replace',
    '<': 'extend_prev_char',
    '>': 'extend_next_char',
    'A-e': 'extend_prev_sub_word_start',
    'A-f': 'extend_next_sub_word_end',
    'C-,': 'extend_till_prev_char',
    'C-.': 'extend_till_char',
    'C-end': 'extend_parent_node_end',
    'C-home': 'extend_parent_node_start',
    'E': 'extend_prev_long_word_start',
    'F': 'extend_next_long_word_end',
    'J': ['extend_to_line_bounds', 'select_line_below'],
    'K': ['extend_to_line_bounds', 'select_line_above'],
    'a': 'normal_mode',
    'e': 'extend_prev_word_start',
    'end': 'extend_to_line_end_newline',
    'f': 'extend_next_word_end',
    'h': 'extend_char_left',
    'home': 'extend_to_line_start',
    'j': 'extend_visual_line_down',
    'k': 'extend_visual_line_up',
    'l': 'extend_char_right',
    # [[sort off]]
    'L': [
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
        'extend_char_right',
    ],
    'H': [
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
        'extend_char_left',
    ],
    'g': {
        # [[sort on]]
        'H': 'extend_to_line_start',
        'L': 'extend_to_line_end_newline',
        'h': 'extend_to_first_nonwhitespace',
        'i': 'extend_to_file_start',
        'l': 'extend_to_line_end',
        'o': 'extend_to_file_end',
        # [[sort off]]
    },
}

insert_mappings: dict[str, Any] = {
    # [[sort on]]
    'C-h': 'commit_undo_checkpoint',
    'C-j': '@<esc>jski<C-v>',
    'C-k': '@<esc>ksji<C-v>',
    'C-l': '@<C-h> \\<ret>',
    'C-u': 'kill_to_line_start',
    'C-v': ['collapse_selection', 'paste_before'],
    'C-ц': ['normal_mode', 'move_prev_word_start', 'change_selection'],
    'F11': [':write-quit-all'],
    'down': 'completion',
    'end': ['commit_undo_checkpoint', 'insert_at_line_end'],
    'home': ['commit_undo_checkpoint', 'insert_at_line_start'],
    'left': ['commit_undo_checkpoint', 'move_char_left'],
    'right': ['commit_undo_checkpoint', 'move_char_right'],
    'up': 'completion',
    # [[sort off]]
    'C-a': [
        'collapse_selection',
        ':insert-output fish -c "uclanr | read"',
        'append_mode_same_line',
    ],
    'C-;': 'harp_register',
}

all_modes = rusify(all_modes_mappings)
normal_select_mode = rusify(normal_select_mappings)
normal_insert_mode = rusify(normal_insert_mappings)
normal_mode = rusify(normal_mappings)
select_mode = rusify(select_mappings)
insert_mode = rusify(insert_mappings)

normal_final = deep_merge(all_modes, normal_select_mode)
normal_final = deep_merge(normal_final, normal_insert_mode)
normal_final = deep_merge(normal_final, normal_mode)

select_final = deep_merge(all_modes, normal_select_mode)
select_final = deep_merge(select_final, select_mode)

insert_final = deep_merge(all_modes, normal_insert_mode)
insert_final = deep_merge(insert_final, insert_mode)

mappings: dict[str, Any] = {
    'normal': normal_final,
    'select': select_final,
    'insert': insert_final,
}

entire_config: dict[str, Any] = {
    'theme': 'gruvbox_material',
    'editor': editor,
    'keys': mappings,
}

with open('/home/axlefublr/fes/dot/helix/config.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['bufferline'] = 'never'

with open('/home/axlefublr/fes/dot/helix/sleek.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['keys']['normal'][':'] = ':quit-all!'
entire_config['keys']['select'][':'] = ':quit-all!'
entire_config['editor']['soft-wrap']['enable'] = False

with open('/home/axlefublr/fes/dot/helix/pager.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['bufferline'] = 'always'

with open('/home/axlefublr/fes/dot/helix/man.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['gutters-right']['layout'] = []

with open('/home/axlefublr/fes/dot/helix/screen.toml', 'w') as file:
    toml.dump(entire_config, file)
