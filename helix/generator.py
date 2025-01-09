#!/usr/bin/env python3

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
    'auto-signature-help': False,
    'display-inlay-hints': False,
    'display-signature-help-docs': True,
    'snippets': True,
    'goto-reference-include-declaration': False,
    'display-messages': True,
}

editor: dict[str, Any] = {
    'should-statusline': False,
    'ephemeral-messages': False,
    'whichkey': False,
    'disable-dot-repeat': True,
    'show-diagnostics': True,
    'continue-comments': False,
    'scrolloff': 99,
    'shell': ['fish', '-c'],
    'line-number': 'relative',
    'auto-completion': True,
    'auto-format': True,
    'completion-timeout': 5,
    'preview-completion-insert': True,
    'completion-trigger-len': 2,
    'auto-info': True,
    'color-modes': True,
    'text-width': 110,
    'default-line-ending': 'lf',
    'insert-final-newline': True,
    'jump-label-alphabet': 'fjdkslaeiwoghruxcz/vmtyqp',
    'default-yank-register': '+',
    # 'bufferline': 'multiple',
    # 'idle-timeout': 250,
    'soft-wrap': {
        'enable': True,
        'max-wrap': 0,
        'wrap-indicator': '',
    },
    'smart-tab': {
        'enable': False,
        'supercede-menu': True,
    },
    'cursor-shape': {'insert': 'bar'},
    'auto-save': {'focus-lost': False},
    'whitespace': {
        'render': {
            'newline': 'all',
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
    'file-picker': {
        'hidden': False,  # also shows "dot files" in results
    },
    'inline-diagnostics': {
        'cursor-line': 'info',
        'other-lines': 'info',
        'max-wrap': 0,
    },
    'statusline': statusline,
    'lsp': lsp,
    'persistence': {
        'old-files': True,
        'commands': False,
        'search': False,
        'clipboard': True,
        'old-files-trim': 200,
        # 'search-trim': 200,
        # 'commands-trim': 200,
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


def rusify(english_dict: dict[str, Any]) -> dict[str, Any]:
    russian_dict = {}

    for key, value in english_dict.items():
        russian_key = transform(key)
        if russian_key is None:
            # sys.stderr.write(f"I don't know {key}\n")
            continue
        if isinstance(value, dict):
            russian_dict[russian_key] = rusify(value)
        else:
            russian_dict[russian_key] = value

    return russian_dict


normal_mappings: dict[str, Any] = {
    'F': 'find_till_char',
    'T': 'till_prev_char',
    'f': 'find_next_char',
    't': 'find_prev_char',
    'h': 'move_char_left',
    'l': 'move_char_right',
    'x': 'select_mode',
    'j': 'move_visual_line_down',
    'k': 'move_visual_line_up',
    'D': ['collapse_selection', 'move_char_left', 'delete_selection'],
    'y': 'move_prev_word_end',
    'Y': 'move_prev_long_word_end',
}
normal_overrides: dict[str, Any] = {
    'g': {
        'y': 'move_prev_sub_word_end',
    },
}
normal_mappings.update(**rusify(normal_mappings))

select_mappings: dict[str, Any] = {
    'F': 'extend_till_char',
    'T': 'extend_till_prev_char',
    'f': 'extend_next_char',
    't': 'extend_prev_char',
    'h': 'extend_char_left',
    'l': 'extend_char_right',
    'A-i': 'extend_parent_node_start',
    'A-o': 'extend_parent_node_end',
    'x': 'normal_mode',
    'j': 'extend_visual_line_down',
    'k': 'extend_visual_line_up',
    'y': 'extend_prev_word_end',
    'Y': 'extend_prev_long_word_end',
}
select_overrides: dict[str, Any] = {
    'g': {
        'y': 'extend_prev_sub_word_end',
    },
}
select_mappings.update(**rusify(select_mappings))

insert_mappings: dict[str, Any] = {
    "A-'": 'insert_register',
    'A-/': ':xa!',
    'C-j': ['normal_mode', 'open_below'],
    'C-k': ['normal_mode', 'open_above'],
    'A-,': 'unindent',
    'A-.': 'indent',
    'C-ц': ['normal_mode', 'move_prev_word_start', 'change_selection'],
    'C-u': 'kill_to_line_start',
    'A-;': ['collapse_selection', 'paste_before'],
    'C-v': ['collapse_selection', 'paste_before'],
    'C-n': 'completion',
    'C-p': 'completion',
    'A-u': 'signature_help',
}
insert_mappings.update(**rusify(insert_mappings))

normal_insert_mappings: dict[str, Any] = {
    'A-i': 'move_parent_node_start',
    'A-o': 'move_parent_node_end',
}
normal_insert_mappings.update(**rusify(normal_insert_mappings))
normal_mappings.update(**normal_insert_mappings)
insert_mappings.update(**normal_insert_mappings)

normal_select_mappings: dict[str, Any] = {
    '`': 'switch_case',
    '~': 'switch_to_lowercase',
    '.': 'toggle_line_select',
    'A-,': 'decrement',
    'A-.': 'increment',
    'o': 'paste_after',
    'O': 'paste_before',
    'a': 'open_below',
    'A': 'open_above',
    'H': 'page_cursor_half_up',
    'L': 'page_cursor_half_down',
    'ret': 'command_mode',
    ',': 'flip_selections',
    'G': 'goto_word',
    'A-;': 'ensure_selections_forward',
    '+': 'remove_primary_selection',
    'J': 'keep_primary_selection',
    'X': 'join_selections_space',
    'V': 'extend_line_above',
    'v': 'extend_line_below',
    'D': ['delete_selection', 'move_char_left'],
    'R': 'repeat_last_motion',
    '$': 'remove_selections',
    'K': ':write-buffer-close-or-quit',
    "'": ':write-all',
    'M': 'save_selection',
    'A-h': 'select_prev_sibling',
    'A-l': 'select_next_sibling',
    'C-n': 'shrink_selection',
    'A-j': 'shrink_selection',
    'C-p': 'expand_selection',
    'A-k': 'expand_selection',
    '\\': 'shell_pipe',
    '|': 'shell_pipe_to',
    '{': 'goto_prev_paragraph',
    '}': 'goto_next_paragraph',
    '#': 'toggle_comments',
    'C-j': ['normal_mode', 'open_below'],
    'C-k': ['normal_mode', 'open_above'],
    's': 'yank',
    'S': ':buffer-close-or-quit!',
    '@': 'replay_macro',
    'q': 'select_regex',
    'Q': 'split_selection',
    'A-m': 'split_selection_on_newline',
    ':': 'replace_with_yanked',
    'i': 'insert_mode',
    'p': 'append_mode',
    'I': 'insert_at_line_start',
    'P': 'insert_at_line_end',
    'd': 'delete_selection',
    '%': ['save_selection', 'select_all'],
    'Z': 'harp_cwd_get',
    'A-s': 'yank_joined',
    'm': {
        'g': ':set gutters.layout ["diff"]',
        'G': ':set gutters.layout []',
        'p': ':toggle should-statusline',
        # 'w': ':toggle whichkey',
        'F': ':echopy %R',
        'f': ':echopy %P',
        'z': ':echopy %W',
        'Z': ':sh ghl | copy',
        'v': ':sh ghl %r | copy',
        'V': ':sh ghl -pb HEAD %r | copy',
        'k': ':toggle show-diagnostics',
        'c': ':pipe wc -c',
        'C': ':pipe wc -l',
        'o': ':toggle auto-format',
        'q': 'count_selections',
        'l': ':toggle lsp.display-inlay-hints',
        't': 'surround_add_tag',
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
        },
    },
    'space': {
        'z': 'harp_cwd_get',
        'Z': 'harp_cwd_set',
        's': 'harp_file_get',
        'S': 'harp_file_set',
        'r': 'harp_relative_file_get',
        'R': 'harp_relative_file_set',
        'w': 'harp_search_get',
        'W': 'harp_search_set',
        'q': 'harp_register_get',
        'Q': 'harp_register_set',
        'a': 'harp_command_get',
        'A': 'harp_command_set',
        'm': ':sh over --cwd=%w yazi',
        'M': ':sh over --cwd=%h yazi',
        'h': ':sh over --cwd=%w lazygit',
        'H': ':sh over --cwd=%h lazygit',
        'f': 'file_picker_in_current_directory',
        'F': 'file_picker_in_current_buffer_directory',
        'e': 'buffer_picker',
        'c': 'code_action',
        'J': 'command_palette',
        'd': magazine_openers,
        '$': 'shell_keep_pipe',
        'l': 'symbol_picker',
        'L': 'workspace_symbol_picker',
        'j': 'global_search',
        'o': ['add_newline_below', 'move_line_down', 'paste_before'],
        'O': ['add_newline_above', 'move_line_up', 'paste_before'],
        **disable(
            [
                # [[sort on]]
                'A-c',
                'C',
                'D',
                'G',
                'Y',
                'b',
                # [[sort off]]
            ]
        ),
    },
    'g': {
        'e': 'move_next_sub_word_end',
        'w': 'move_next_sub_word_start',
        'b': 'move_prev_sub_word_start',
        'h': 'goto_first_nonwhitespace',
        'H': 'goto_line_start',
        'l': 'goto_line_end',
        'L': 'goto_line_end_newline',
        'm': 'goto_last_accessed_file',
        'M': 'goto_last_modified_file',
        'o': 'goto_file_end',
        'i': 'goto_file_start',
        '$': 'keep_selections',
        'X': 'join_selections',
        'u': 'goto_reference',
        'g': 'select_references_to_symbol_under_cursor',
        '*': 'make_search_word_bounded',
        '@': 'record_macro',
        's': 'goto_type_definition',
        'q': [':cd %h', ':cd %g'],
        'Q': ':cd %h',
        'a': 'rename_symbol',
        'I': 'goto_implementation',
        **disable(
            [
                # [[sort on]]
                'D',
                'c',
                'r',
                't',
                # [[sort off]]
            ]
        ),
    },
    'z': {
        'k': 'rotate_view_reverse',
        'j': 'rotate_view',
        'J': 'hsplit',
        'K': ':hsplit-new',
        ';': [':write-all', ':buffer-close-all'],
        ':': ':buffer-close-all!',
        'u': 'signature_help',
        # 'u': 'transpose_view',
        'o': 'wclose',
        'O': 'wonly',
        'h': ['collapse_selection', 'extend_to_first_nonwhitespace'],
        'H': ['collapse_selection', 'extend_to_line_start'],
        'l': ['collapse_selection', 'extend_to_line_end'],
        'L': ['collapse_selection', 'extend_to_line_end_newline'],
        'M': 'merge_consecutive_selections',
        'm': 'merge_selections',
        ',': ':sort',
        '<': ['select_all', 'split_selection_on_newline', ':sort', 'keep_primary_selection'],
        '.': ':random',
        '>': ['select_all', 'split_selection_on_newline', ':random', 'keep_primary_selection'],
        'n': 'select_all_siblings',
        'N': 'select_all_children',
        "'": ':reload-all',
        '"': ':reload!',
        'z': ':config-reload',
        'i': 'hover',
        'I': 'hover_dump',
        '/': 'select_first_and_last_chars',
        '?': 'reverse_selection_contents',
        'w': [':cd ~/prog/wks', ':e src/main.rs'],
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
    },
    **disable(
        [
            # [[sort on]]
            'A-:',
            'C-c',
            'C-s',
            'down',
            'left',
            'right',
            'up',
            # [[sort off]]
        ]
    ),
}
normal_select_mappings.update(**rusify(normal_select_mappings))
normal_mappings.update(**normal_select_mappings)
select_mappings.update(**normal_select_mappings)
normal_mappings['g'].update(**normal_overrides['g'])
select_mappings['g'].update(**select_overrides['g'])

mappings: dict[str, Any] = {
    'normal': normal_mappings,
    'select': select_mappings,
    'insert': insert_mappings,
}

entire_config: dict[str, Any] = {
    'theme': 'gruvbox_material',
    'editor': editor,
    'keys': mappings,
}

with open('/home/axlefublr/prog/dotfiles/helix/config.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['keys']['normal']['K'] = ':write-quit-all'
entire_config['keys']['select']['K'] = ':write-quit-all'
entire_config['keys']['normal']['S'] = ':quit-all!'
entire_config['keys']['select']['S'] = ':quit-all!'

with open('/home/axlefublr/prog/dotfiles/helix/quit.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['whitespace']['render']['newline'] = 'none'
entire_config['editor']['gutters']['layout'] = []
entire_config['keys']['normal']['K'] = ':quit-all!'
entire_config['keys']['select']['K'] = ':quit-all!'

with open('/home/axlefublr/prog/dotfiles/helix/man.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['soft-wrap']['enable'] = False
entire_config['editor']['scrolloff'] = 0

with open('/home/axlefublr/prog/dotfiles/helix/wrap-off.toml', 'w') as file:
    toml.dump(entire_config, file)
