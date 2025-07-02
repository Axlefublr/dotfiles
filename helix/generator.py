#!/usr/bin/env python3

# ruff: noqa: E501

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
    'bufferline-index': True,
    'disable-dot-repeat': True,
    'ephemeral-messages': False,
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
        'mark': 'directory',
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
    'shell': ['fish', '-c'],
    'statusline': statusline,
    'text-width': 110,
    'trim-final-newlines': True,
    'trim-trailing-whitespace': True,
    # [[sort off]]
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
    # 'persistence': {
    #     'old-files': True,
    #     'commands': True,
    #     'search': True,
    #     'clipboard': True,
    #     'old-files-trim': 200,
    # 'search-trim': 200,
    # 'commands-trim': 200,
    # },
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
    'A-end': 'move_parent_node_end',
    'A-home': 'move_parent_node_start',
    'A-ins': ':quit!',
    'A-left': 'unindent',
    'A-right': 'indent',
    'C-down': 'add_newline_below',
    'C-e': ':new',
    'C-l': 'hover',
    'C-s': 'signature_help',
    'C-t': ':reload!',
    'C-up': 'add_newline_above',
    'F1': ':sh footclient -ND %(buffer_parent) 2>/dev/null',
    'F2': ':sh footclient -ND %(working_directory) 2>/dev/null',
    'S-home': ':buffer-close!',
    # [[sort off]]
    'C-z': [
        ":noop %sh(echo '%(working_directory)' >~/.cache/mine/helix-cwd-suspend)",
        ":noop %sh(echo '%(buffer_parent)' >~/.cache/mine/helix-buffer-head-suspend)",
        ':write-all',
        'suspend',
    ],
    'F6': [
        ':sh rm -f /tmp/cami-yazi-chooser-file',
        ':noop %sh(footclient yazi %{full_path} --chooser-file=/tmp/cami-yazi-chooser-file)',
        ':open %sh{cat /tmp/cami-yazi-chooser-file}',
        ':reload-all',
    ],
    'F3': [
        ':sh rm -f /tmp/cami-yazi-chooser-file',
        ':noop %sh(footclient yazi --chooser-file=/tmp/cami-yazi-chooser-file)',
        ':open %sh{cat /tmp/cami-yazi-chooser-file}',
        ':reload-all',
    ],
}

normal_select_mappings: dict[str, Any] = {
    **disable(
        [
            # [[sort on]]
            'P',
            'Z',
            'p',
            # [[sort off]]
        ]
    ),
    # [[sort on]]
    "'": [':write-all', ':reload-all'],
    '!': 'keep_primary_selection',
    '#': 'yank_joined',
    '$': 'remove_selections',
    '%': ['save_selection', 'select_all'],
    '(': 'goto_prev_change',
    ')': 'goto_next_change',
    '*': 'search_selection_detect_word_boundaries',
    '+': 'rotate_selections_forward',
    ',': 'collapse_selection',
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
    ';': 'select_regex',
    '<': ['goto_previous_buffer', ':echo %{full_path}'],
    '=': 'remove_primary_selection',
    '>': ['goto_next_buffer', ':echo %{full_path}'],
    '@': 'toggle_comments',
    'A-.': 'shrink_to_line_bounds',
    'A-/': 'select_first_and_last_chars',
    'A-N': 'extend_search_prev',
    'A-h': 'select_prev_sibling',
    'A-i': 'select_references_to_symbol_under_cursor',
    'A-j': 'shrink_selection',
    'A-k': 'expand_selection',
    'A-l': 'select_next_sibling',
    'A-m': 'select_all_siblings',
    'A-n': 'extend_search_next',
    'A-u': 'select_all_children',
    'A-v': 'ensure_selections_forward',
    'B': 'open_above',
    'C': 'repeat_last_motion',
    'C-.': 'trim_selections',
    'C-;': 'split_selection',
    'C-A-m': 'merge_consecutive_selections',
    'C-[': 'decrement',
    'C-]': 'increment',
    'C-c': 'change_selection_noyank',
    'C-d': 'delete_selection_noyank',
    'C-j': 'copy_selection_on_next_line',
    'C-k': 'copy_selection_on_prev_line',
    'C-m': 'merge_selections',
    'C-q': ':cd ..',
    'C-tab': ':edit %sh(ypoc)',
    'C-w': ':write-buffer-close',
    'C-x': 'join_selections',
    'D': ['delete_selection_noyank', 'move_char_left'],
    'I': 'insert_at_line_start',
    'M': ':write-buffer-close',
    'N': 'search_prev',
    'O': 'paste_before',
    'S': 'goto_word',
    'S-pagedown': 'goto_next_paragraph',
    'S-pageup': 'goto_prev_paragraph',
    'T': 'redo',
    'U': 'insert_at_line_end',
    'W': 'replace_with_yanked',
    'X': 'join_selections_space',
    'Z': ':append-output echo "\n"',
    '\\': ':sort',
    '^': 'make_search_word_bounded',
    '_': 'switch_to_lowercase',
    '`': 'switch_case',
    'b': 'open_below',
    'd': 'delete_selection',
    'del': ':write!',
    'i': 'insert_mode',
    'n': 'search_next',
    'o': 'paste_after',
    'pagedown': 'page_cursor_half_down',
    'pageup': 'page_cursor_half_up',
    'ret': 'command_mode',
    's': 'yank',
    't': 'undo',
    'tab': ':edit %sh(cat ~/.cache/mine/shell-cwd)',
    'u': 'append_mode_same_line',
    'v': 'flip_selections',
    '{': 'rotate_selections_first',
    '|': 'shell_pipe',
    '}': 'rotate_selections_last',
    '‘': 'rotate_selection_contents_backward',
    '’': 'rotate_selection_contents_forward',
    '‚': 'reverse_selection_contents',
    '“': 'goto_prev_diag',
    '”': 'goto_next_diag',
    '…': 'split_selection_on_newline',
    '€': 'keep_selections',
    '🚀': 'rename_symbol',
    # [[sort off]]
    'm': {
        # [[sort on]]
        # 'X': ':echo lines: %sh{echo -n "%{selection}" >/tmp/cami-helix-temp ; wc -l /tmp/cami-helix-temp | cut -d " " -f 1}',
        # 'x': ':echo chars: %sh{echo -n "%{selection}" >/tmp/cami-helix-temp ; wc -c /tmp/cami-helix-temp | cut -d " " -f 1}',
        ';': ':toggle whitespace.render %sh(toggle_value -n helix-newline \'{"newline": "all"}\' \'{"newline": null}\')',
        'C': ':echopy %(relative_path)',
        'M': ':sh chmod +x %(full_path)',
        'V': ':echopy %sh(ghl -pb HEAD %(relative_path))',
        'Z': ':echopy %sh(ghl)',
        'a': ['save_selection', 'select_textobject_around'],
        'c': ':echopy %(full_path)',
        'f': ['save_selection', 'select_textobject_inner'],
        'i': 'count_selections',
        'k': ':toggle show-diagnostics',
        'l': ':toggle lsp.display-inlay-hints',
        'o': ':toggle auto-format',
        'p': ':toggle should-statusline',
        'v': ':echopy %sh(ghl %(relative_path))',
        'x': 'surround_replace',
        'z': ':echopy %(working_directory)',
        # [[sort off]]
        't': {
            'k': ':pipe mst kbd',
            'b': ':pipe mst b',
            'h': ':pipe mst h',
            'd': ':pipe mst div',
            'c': ':pipe mst cd',
            'o': ':pipe mst o',
            'i': ':pipe mst i',
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
            '`': ':pipe wrap-in-block.rs `',
            'e': ':pipe wrap-in-block.rs begin',
            '"': ':pipe wrap-in-block.rs \\"',
        },
        'r': {
            'T': ['save_selection', 'goto_next_test'],
            'e': ['save_selection', 'goto_next_entry'],
            'c': ['save_selection', 'goto_next_comment'],
            'f': ['save_selection', 'goto_next_function'],
            'a': ['save_selection', 'goto_next_parameter'],
            't': ['save_selection', 'goto_next_class'],
            'g': ['save_selection', 'goto_last_change'],
            'd': ['save_selection', 'goto_last_diag'],
        },
        'q': {
            'T': ['save_selection', 'goto_prev_test'],
            'e': ['save_selection', 'goto_prev_entry'],
            'c': ['save_selection', 'goto_prev_comment'],
            'f': ['save_selection', 'goto_prev_function'],
            'a': ['save_selection', 'goto_prev_parameter'],
            't': ['save_selection', 'goto_prev_class'],
            'g': ['save_selection', 'goto_first_change'],
            'd': ['save_selection', 'goto_first_diag'],
        },
        'R': {
            'g': ['save_selection', 'goto_last_change'],
            'd': ['save_selection', 'goto_last_diag'],
        },
        'Q': {
            'g': ['save_selection', 'goto_first_change'],
            'd': ['save_selection', 'goto_first_diag'],
        },
    },
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
        ':': 'diagnostics_picker',
        ';': 'buffer_picker',
        'I': 'local_search_grep',
        'J': 'command_palette',
        'K': 'file_picker_in_current_buffer_directory',
        'L': 'workspace_symbol_picker',
        'O': ['add_newline_above', 'move_line_up', 'paste_before'],
        'a': 'harp_command',
        'c': 'global_search',
        'd': magazine_openers,
        'e': 'harp_mark',
        'f': 'harp_search',
        'i': 'local_search_fuzzy',
        'j': 'global_search',
        'k': 'file_picker_in_current_directory',
        'l': 'symbol_picker',
        'o': ['add_newline_below', 'move_line_down', 'paste_before'],
        'r': 'harp_relative_file',
        's': 'harp_file',
        'w': 'harp_register',
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
                't',
                # [[sort off]]
            ]
        ),
        # [[sort on]]
        'F': ':e %sh(ypoc)',
        'a': ':buffer-close-all',
        'd': ':buffer-close-others',
        'g': ':reset-diff-change',
        'm': 'goto_last_accessed_file',
        'q': ':cd %(buffer_parent)',
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
        'c': ':pipe qalc -t (read -z)',
        'i': 'goto_type_definition',
        'j': 'goto_definition',
        'k': 'goto_reference',
        'o': 'code_action',
        'z': [':noop %sh{python ~/fes/dot/helix/generator.py}', ':config-reload'],
        # [[sort off]]
    },
}

normal_insert_mappings: dict[str, Any] = {}

normal_mappings: dict[str, Any] = {
    # [[sort on]]
    'A-e': ['move_prev_sub_word_start', 'trim_selections'],
    'A-f': ['move_next_sub_word_end', 'trim_selections'],
    'D': ['collapse_selection', 'move_char_left', 'delete_selection'],
    'E': ['move_prev_long_word_start', 'trim_selections'],
    'F': ['move_next_long_word_end', 'trim_selections'],
    'J': ['extend_to_line_bounds', 'extend_line_below'],
    'K': ['extend_to_line_bounds', 'extend_line_above'],
    'Q': 'till_prev_char',
    'R': 'find_till_char',
    'a': 'select_mode',
    'e': ['move_prev_word_start', 'trim_selections'],
    'f': ['move_next_word_end', 'trim_selections'],
    'h': 'move_char_left',
    'j': 'move_visual_line_down',
    'k': 'move_visual_line_up',
    'l': 'move_char_right',
    'q': 'find_prev_char',
    'r': 'find_next_char',
    'w': ['collapse_selection', 'replace'],
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
    'A-e': 'extend_prev_sub_word_start',
    'A-f': 'extend_next_sub_word_end',
    'E': 'extend_prev_long_word_start',
    'F': 'extend_next_long_word_end',
    'J': ['extend_to_line_bounds', 'select_line_below'],
    'K': ['extend_to_line_bounds', 'select_line_above'],
    'Q': 'extend_till_prev_char',
    'R': 'extend_till_char',
    'a': 'normal_mode',
    'e': 'extend_prev_word_start',
    'end': 'extend_parent_node_end',
    'f': 'extend_next_word_end',
    'h': 'extend_char_left',
    'home': 'extend_parent_node_start',
    'j': 'extend_visual_line_down',
    'k': 'extend_visual_line_up',
    'l': 'extend_char_right',
    'q': 'extend_prev_char',
    'r': 'extend_next_char',
    'w': 'replace',
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
    'C-j': ['normal_mode', 'open_below'],
    'C-k': ['normal_mode', 'open_above'],
    'C-u': 'kill_to_line_start',
    'C-v': ['collapse_selection', 'paste_before'],
    'C-ц': ['normal_mode', 'move_prev_word_start', 'change_selection'],
    'F12': [':write-quit-all'],
    'down': 'completion',
    'up': 'completion',
    # [[sort off]]
    'C-;': [
        'collapse_selection',
        ':insert-output uclanr | read',
        'append_mode_same_line',
    ],
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

entire_config['editor']['whitespace']['render']['newline'] = 'none'
entire_config['editor']['gutters']['layout'] = []
entire_config['keys']['normal'][':'] = ':quit-all!'
entire_config['keys']['select'][':'] = ':quit-all!'

# hotkeys that may write and close the current buffer now close entire helix without saving
with open('/home/axlefublr/fes/dot/helix/pager.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['gutters-right']['layout'] = []
# entire_config['editor']['soft-wrap']['enable'] = False
# entire_config['editor']['scrolloff'] = 0

# meant for using helix to view a screen; wrapping disabled because of the line ending characters
with open('/home/axlefublr/fes/dot/helix/screen.toml', 'w') as file:
    toml.dump(entire_config, file)
