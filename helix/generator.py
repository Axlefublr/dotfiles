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
    'disable-dot-repeat': True,
    'ephemeral-messages': False,
    'should-statusline': False,
    'show-diagnostics': True,
    'whichkey': False,
    'word-completion-trigger-length': 4,
    # [[sort off]]
    # [[sort on]]
    # 'bufferline': 'multiple',
    # 'idle-timeout': 250,
    'auto-completion': True,
    'auto-format': True,
    'auto-info': True,
    'auto-save': {'focus-lost': False},
    'color-modes': True,
    'completion-timeout': 5,
    'completion-trigger-len': 2,
    'continue-comments': False,
    'cursor-shape': {'insert': 'bar'},
    'default-line-ending': 'lf',
    'default-yank-register': '+',
    'insert-final-newline': True,
    'jump-label-alphabet': 'fjdkslaeiwoghruxcz/vmtyqp',
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
    'C-a': 'signature_help',
    'C-s': 'hover',
    'end': 'move_parent_node_end',
    'home': 'move_parent_node_start',
    # [[sort off]]
}

normal_select_mappings: dict[str, Any] = {
    **disable(
        [
            # [[sort on]]
            'P',
            'p',
            # [[sort off]]
        ]
    ),
    # [[sort on]]
    "'": [':write-all', ':reload-all'],
    '!': 'keep_primary_selection',
    '#': 'toggle_comments',
    '$': 'remove_selections',
    '%': ['save_selection', 'select_all'],
    '+': 'rotate_selections_forward',
    ',': 'collapse_selection',
    '-': 'rotate_selections_backward',
    '.': 'toggle_line_select',
    ':': ':write-quit-all',
    ';': 'flip_selections',
    '<': ['goto_previous_buffer', ':echo %{full_path}'],
    '=': 'remove_primary_selection',
    '>': ['goto_next_buffer', ':echo %{full_path}'],
    '@': 'replay_macro',
    'A': 'split_selection',
    'A-:': ':write-quit-all!',
    'A-M': ':buffer-close!',
    'A-S': ':yank-join \\ ',
    'A-down': 'copy_selection_on_next_line',
    'A-h': 'select_prev_sibling',
    'A-j': 'shrink_selection',
    'A-k': 'expand_selection',
    'A-l': 'select_next_sibling',
    'A-left': 'unindent',
    'A-n': 'select_all_siblings',
    'A-p': 'select_all_children',
    'A-right': 'indent',
    'A-s': 'yank_joined',
    'A-up': 'copy_selection_on_prev_line',
    'B': 'open_above',
    'C-/': 'select_first_and_last_chars',
    'C-A-m': 'merge_consecutive_selections',
    'C-[': 'decrement',
    'C-]': 'increment',
    'C-c': 'change_selection_noyank',
    'C-d': 'delete_selection_noyank',
    'C-l': '@Hmam',
    'C-m': 'merge_selections',
    'C-n': 'shrink_selection',
    'C-p': 'expand_selection',
    'C-q': ':cd ..',
    'D': ['delete_selection', 'move_char_left'],
    'G': 'goto_word',
    'H': 'save_selection',
    'I': 'insert_at_line_start',
    'J': 'goto_next_paragraph',
    'K': 'goto_prev_paragraph',
    'L': 'repeat_last_motion',
    'M': ':write-buffer-close',
    'O': 'paste_before',
    'T': 'redo',
    'U': 'insert_at_line_end',
    'V': 'extend_line_above',
    'W': 'replace_with_yanked',
    'X': 'join_selections_space',
    '\\': ':sort',
    '_': 'switch_to_lowercase',
    '`': 'switch_case',
    'a': 'select_regex',
    'b': 'open_below',
    'd': 'delete_selection',
    'i': 'insert_mode',
    'o': 'paste_after',
    'pagedown': 'page_cursor_half_down',
    'pageup': 'page_cursor_half_up',
    'ret': 'command_mode',
    's': 'yank',
    't': 'undo',
    'u': 'append_mode_same_line',
    'v': 'extend_line_below',
    'w': 'replace',
    '|': 'shell_pipe',
    '~': 'switch_to_lowercase',
    '÷': 'switch_case',
    '“': 'goto_prev_change',
    '”': 'goto_next_change',
    '…': 'split_selection_on_newline',
    '€': 'keep_selections',
    # [[sort off]]
    'C-j': [
        'select_mode',
        'ensure_selections_forward',
        'extend_char_left',
        'flip_selections',
        'extend_char_right',
        'ensure_selections_forward',
        'normal_mode',
    ],
    'C-k': [
        'select_mode',
        'ensure_selections_forward',
        'extend_char_right',
        'flip_selections',
        'extend_char_left',
        'ensure_selections_forward',
        'normal_mode',
    ],
    'C-,': [
        'extend_to_line_bounds',
        'split_selection_on_newline',
        ':sort',
        'keep_primary_selection',
        'collapse_selection',
    ],
    'm': {
        # [[sort on]]
        ';': ':toggle whitespace.render %sh(toggle_value -n helix-newline \'{"newline": "all"}\' \'{"newline": null}\')',
        'C': ':echo lines: %sh{echo -n "%{selection}" >/tmp/cami-helix-temp ; wc -l /tmp/cami-helix-temp | cut -d " " -f 1}',
        'F': ':echopy %(relative_path)',
        'V': ':echo %sh{ghl -pb HEAD %(relative_path) | tee ~/.local/share/flipboard}',
        'Z': ':echo %sh{ghl | tee ~/.local/share/flipboard}',
        'c': ':echo chars: %sh{echo -n "%{selection}" >/tmp/cami-helix-temp ; wc -c /tmp/cami-helix-temp | cut -d " " -f 1}',
        'f': ':echopy %(full_path)',
        'k': ':toggle show-diagnostics',
        'l': ':toggle lsp.display-inlay-hints',
        'o': ':toggle auto-format',
        'p': ':toggle should-statusline',
        'q': 'count_selections',
        't': 'surround_add_tag',
        'v': ':echo %sh{ghl %(relative_path) | tee ~/.local/share/flipboard}',
        'z': ':echopy %(working_directory)',
        # [[sort off]]
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
        '$': 'shell_keep_pipe',
        'A': 'harp_command_set',
        'C': ':sh footclient -D %(buffer_parent) lazygit 2>/dev/null',
        'F': 'file_picker_in_current_buffer_directory',
        'J': 'command_palette',
        'L': 'workspace_symbol_picker',
        'O': ['add_newline_above', 'move_line_up', 'paste_before'],
        'R': 'harp_relative_file_set',
        'S': 'harp_file_set',
        'V': ':sh footclient -D %(buffer_parent) yazi 2>/dev/null',
        'a': 'harp_command_get',
        'c': ':sh footclient -D %(working_directory) lazygit 2>/dev/null',
        'd': magazine_openers,
        'e': 'buffer_picker',
        'f': 'file_picker_in_current_directory',
        'j': 'global_search',
        'k': 'local_search_fuzzy',
        'l': 'symbol_picker',
        'm': 'code_action',
        'o': ['add_newline_below', 'move_line_down', 'paste_before'],
        'r': 'harp_relative_file_get',
        's': 'harp_file_get',
        'v': ':sh footclient -D %(working_directory) yazi 2>/dev/null',
        # [[sort off]]
    },
    'g': {
        **disable(
            [
                # [[sort on]]
                'c',
                'r',
                't',
                # [[sort off]]
            ]
        ),
        # [[sort on]]
        '(': 'rotate_selection_contents_forward',
        ')': 'rotate_selection_contents_backward',
        'F': ':e %sh(ypoc)',
        'I': 'goto_implementation',
        'X': 'join_selections',
        'a': 'rename_symbol',
        'g': 'select_references_to_symbol_under_cursor',
        'm': 'goto_last_accessed_file',
        'q': ':cd %(buffer_parent)',
        's': 'goto_type_definition',
        'u': 'goto_reference',
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
        '.': ':random',
        '<': ['select_all', 'split_selection_on_newline', ':sort', 'keep_primary_selection'],
        '>': ['select_all', 'split_selection_on_newline', ':random', 'keep_primary_selection'],
        '?': 'reverse_selection_contents',
        'c': ':pipe qalc -t (read -z)',
        'z': [':noop %sh{python ~/r/dot/helix/generator.py}', ':config-reload'],
        # [[sort off]]
    },
    '[': {
        'g': 'goto_first_change',
    },
    ']': {
        'g': 'goto_last_change',
    },
}

normal_insert_mappings: dict[str, Any] = {}

normal_mappings: dict[str, Any] = {
    # [[sort on]]
    'A-E': 'move_prev_long_word_end',
    'A-F': 'move_next_long_word_start',
    'A-e': 'move_prev_word_end',
    'A-f': 'move_next_word_start',
    'C-A-e': 'move_prev_sub_word_end',
    'C-A-f': 'move_next_sub_word_start',
    'C-e': 'move_prev_sub_word_start',
    'C-f': 'move_next_sub_word_end',
    'D': ['collapse_selection', 'move_char_left', 'delete_selection'],
    'E': 'move_prev_long_word_start',
    'F': 'move_next_long_word_end',
    'Q': 'till_prev_char',
    'R': 'find_till_char',
    'e': 'move_prev_word_start',
    'f': 'move_next_word_end',
    'h': 'move_char_left',
    'j': 'move_visual_line_down',
    'k': 'move_visual_line_up',
    'l': 'move_char_right',
    'q': 'find_prev_char',
    'r': 'find_next_char',
    'x': 'select_mode',
    # [[sort off]]
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
    'A-E': 'extend_prev_long_word_end',
    'A-F': 'extend_next_long_word_start',
    'A-e': 'extend_prev_word_end',
    'A-f': 'extend_next_word_start',
    'C-A-e': 'extend_prev_sub_word_end',
    'C-A-f': 'extend_next_sub_word_start',
    'C-e': 'extend_prev_sub_word_start',
    'C-f': 'extend_next_sub_word_end',
    'E': 'extend_prev_long_word_start',
    'F': 'extend_next_long_word_end',
    'Q': 'extend_till_prev_char',
    'R': 'extend_till_char',
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
    'x': 'normal_mode',
    # [[sort off]]
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
    'A-left': 'unindent',
    'A-right': 'indent',
    'C-d': [':write-quit-all'],
    'C-j': ['normal_mode', 'open_below'],
    'C-k': ['normal_mode', 'open_above'],
    'C-u': 'kill_to_line_start',
    'C-v': ['collapse_selection', 'paste_before'],
    'C-ц': ['normal_mode', 'move_prev_word_start', 'change_selection'],
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

with open('/home/axlefublr/r/dot/helix/config.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['whitespace']['render']['newline'] = 'none'
entire_config['editor']['gutters']['layout'] = []
entire_config['keys']['normal'][':'] = ':quit-all!'
entire_config['keys']['select'][':'] = ':quit-all!'

# hotkeys that may write and close the current buffer now close entire helix without saving
with open('/home/axlefublr/r/dot/helix/pager.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['gutters-right']['layout'] = []
# entire_config['editor']['soft-wrap']['enable'] = False
# entire_config['editor']['scrolloff'] = 0

# meant for using helix to view a screen; wrapping disabled because of the line ending characters
with open('/home/axlefublr/r/dot/helix/screen.toml', 'w') as file:
    toml.dump(entire_config, file)
