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
    # [[sort on]]
    'D': ['collapse_selection', 'move_char_left', 'delete_selection'],
    'F': 'find_till_char',
    'T': 'till_prev_char',
    'Y': 'move_prev_long_word_end',
    'f': 'find_next_char',
    'h': 'move_char_left',
    'j': 'move_visual_line_down',
    'k': 'move_visual_line_up',
    'l': 'move_char_right',
    't': 'find_prev_char',
    'x': 'select_mode',
    'y': 'move_prev_word_end',
    # [[sort off]]
}
normal_overrides: dict[str, Any] = {
    'g': {
        'y': 'move_prev_sub_word_end',
    },
}
normal_mappings.update(**rusify(normal_mappings))

select_mappings: dict[str, Any] = {
    # [[sort on]]
    'A-i': 'extend_parent_node_start',
    'A-o': 'extend_parent_node_end',
    'F': 'extend_till_char',
    'T': 'extend_till_prev_char',
    'Y': 'extend_prev_long_word_end',
    'f': 'extend_next_char',
    'h': 'extend_char_left',
    'j': 'extend_visual_line_down',
    'k': 'extend_visual_line_up',
    'l': 'extend_char_right',
    't': 'extend_prev_char',
    'x': 'normal_mode',
    'y': 'extend_prev_word_end',
    # [[sort off]]
}
select_overrides: dict[str, Any] = {
    'g': {
        'y': 'extend_prev_sub_word_end',
    },
}
select_mappings.update(**rusify(select_mappings))

insert_mappings: dict[str, Any] = {
    # [[sort on]]
    "A-'": 'insert_register',
    'A-,': 'unindent',
    'A-.': 'indent',
    'A-;': ['collapse_selection', 'paste_before'],
    'A-u': 'signature_help',
    'C-j': ['normal_mode', 'open_below'],
    'C-k': ['normal_mode', 'open_above'],
    'C-n': 'completion',
    'C-p': 'completion',
    'C-u': 'kill_to_line_start',
    'C-v': ['collapse_selection', 'paste_before'],
    'C-ц': ['normal_mode', 'move_prev_word_start', 'change_selection'],
    # [[sort off]]
}
insert_mappings.update(**rusify(insert_mappings))

normal_insert_mappings: dict[str, Any] = {
    # [[sort on]]
    'A-i': 'move_parent_node_start',
    'A-o': 'move_parent_node_end',
    # [[sort off]]
}
normal_insert_mappings.update(**rusify(normal_insert_mappings))
normal_mappings.update(**normal_insert_mappings)
insert_mappings.update(**normal_insert_mappings)

normal_select_mappings: dict[str, Any] = {
    # [[sort on]]
    "'": ':write-all',
    '#': 'toggle_comments',
    '$': 'remove_selections',
    '%': ['save_selection', 'select_all'],
    '+': 'remove_primary_selection',
    ',': 'flip_selections',
    '.': 'toggle_line_select',
    ':': ':write-quit-all',
    '@': 'replay_macro',
    'A': 'open_above',
    'A-,': 'decrement',
    'A-.': 'increment',
    'A-;': 'ensure_selections_forward',
    'A-S': ':yank-join \\ ',
    'A-h': 'select_prev_sibling',
    'A-j': 'shrink_selection',
    'A-k': 'expand_selection',
    'A-l': 'select_next_sibling',
    'A-m': 'split_selection_on_newline',
    'A-s': 'yank_joined',
    'C-j': ['normal_mode', 'open_below'],
    'C-k': ['normal_mode', 'open_above'],
    'C-n': 'shrink_selection',
    'C-p': 'expand_selection',
    'D': ['delete_selection', 'move_char_left'],
    'G': 'goto_word',
    'H': ':write-buffer-close',
    'I': 'insert_at_line_start',
    'J': 'page_cursor_half_down',
    'K': 'page_cursor_half_up',
    'L': 'replace_with_yanked',
    'M': 'save_selection',
    'O': 'paste_before',
    'P': 'insert_at_line_end',
    'Q': 'split_selection',
    'R': 'repeat_last_motion',
    'S': 'copy_selection_on_prev_line',
    'V': 'extend_line_above',
    'X': 'join_selections_space',
    'Z': 'keep_primary_selection',
    '\\': 'shell_pipe',
    '`': 'switch_case',
    'a': 'open_below',
    'd': 'delete_selection',
    'i': 'insert_mode',
    'o': 'paste_after',
    'p': 'append_mode_same_line',
    'q': 'select_regex',
    'ret': 'command_mode',
    's': 'yank',
    'v': 'extend_line_below',
    '{': 'goto_prev_paragraph',
    '|': 'shell_pipe_to',
    '}': 'goto_next_paragraph',
    '~': 'switch_to_lowercase',
    # [[sort off]]
    'm': {
        # [[sort on]]
        # 'w': ':toggle whichkey',
        ';': ':toggle whitespace.render %sh(toggle_value -n helix-newline \'{"newline": "all"}\' \'{"newline": null}\')',
        'C': ':pipe wc -l',
        'F': ':echopy %(relative_path)',
        'V': ':sh ghl -pb HEAD %(relative_path) | copy',
        'Z': ':sh ghl | copy',
        'c': ':pipe wc -c',
        'f': ':echopy %(full_path)',
        'g': ':toggle gutters.layout ["diff"] []',
        'k': ':toggle show-diagnostics',
        'l': ':toggle lsp.display-inlay-hints',
        'o': ':toggle auto-format',
        'p': ':toggle should-statusline',
        'q': 'count_selections',
        't': 'surround_add_tag',
        'v': ':sh ghl %(relative_path) | copy',
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
        },
    },
    'space': {
        # [[sort on]]
        '$': 'shell_keep_pipe',
        'A': 'harp_command_set',
        'C': ':sh footclient -D %(buffer_parent) lazygit 2>/dev/null',
        'F': 'file_picker_in_current_buffer_directory',
        'I': 'harp_register_set',
        'J': 'command_palette',
        'K': 'harp_search_set',
        'L': 'workspace_symbol_picker',
        'O': ['add_newline_above', 'move_line_up', 'paste_before'],
        'R': 'harp_relative_file_set',
        'S': 'harp_file_set',
        'V': ':sh footclient -D %(buffer_parent) yazi 2>/dev/null',
        'Z': 'harp_cwd_set',
        'a': 'harp_command_get',
        'c': ':sh footclient -D %(working_directory) lazygit 2>/dev/null',
        'd': magazine_openers,
        'e': 'buffer_picker',
        'f': 'file_picker_in_current_directory',
        'h': 'harp_fuzzy_get',
        'i': 'harp_register_get',
        'j': 'global_search',
        'k': 'harp_search_get',
        'l': 'symbol_picker',
        'm': 'code_action',
        'o': ['add_newline_below', 'move_line_down', 'paste_before'],
        'r': 'harp_relative_file_get',
        's': 'harp_file_get',
        'v': ':sh footclient -D %(working_directory) yazi 2>/dev/null',
        'z': 'harp_cwd_get',
        # [[sort off]]
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
    },
    'g': {
        # [[sort on]]
        '$': 'keep_selections',
        '(': 'rotate_selection_contents_forward',
        ')': 'rotate_selection_contents_backward',
        '*': 'make_search_word_bounded',
        '@': 'record_macro',
        'F': ':e %sh(ypoc)',
        'H': 'goto_line_start',
        'I': 'goto_implementation',
        'L': 'goto_line_end_newline',
        'M': 'goto_last_modified_file',
        'Q': ':cd %(buffer_parent)',
        'X': 'join_selections',
        'a': 'rename_symbol',
        'b': 'move_prev_sub_word_start',
        'e': 'move_next_sub_word_end',
        'g': 'select_references_to_symbol_under_cursor',
        'h': 'goto_first_nonwhitespace',
        'i': 'goto_file_start',
        'l': 'goto_line_end',
        'm': 'goto_last_accessed_file',
        'o': 'goto_file_end',
        'q': ':cd ..',
        's': 'goto_type_definition',
        'u': 'goto_reference',
        'w': 'move_next_sub_word_start',
        # [[sort off]]
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
        # [[sort on]]
        "'": ':reload-all',
        # 'u': 'transpose_view',
        ',': ':sort',
        '.': ':random',
        '/': 'select_first_and_last_chars',
        '<': ['select_all', 'split_selection_on_newline', ':sort', 'keep_primary_selection'],
        '>': ['select_all', 'split_selection_on_newline', ':random', 'keep_primary_selection'],
        '?': 'reverse_selection_contents',
        'H': ['collapse_selection', 'extend_to_line_start'],
        'I': 'hover_dump',
        'J': 'hsplit',
        'K': ':hsplit-new',
        'L': ['collapse_selection', 'extend_to_line_end_newline'],
        'M': 'merge_consecutive_selections',
        'N': 'select_all_children',
        'O': 'wonly',
        'h': ['collapse_selection', 'extend_to_first_nonwhitespace'],
        'i': 'hover',
        'j': 'rotate_view',
        'k': 'rotate_view_reverse',
        'l': ['collapse_selection', 'extend_to_line_end'],
        'm': 'merge_selections',
        'n': 'select_all_siblings',
        'o': 'wclose',
        'u': 'signature_help',
        'z': ':config-reload',
        # [[sort off]]
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

with open('/home/axlefublr/r/dot/helix/config.toml', 'w') as file:
    toml.dump(entire_config, file)

# hotkeys that may close the current buffer now close the entire helix, still writing
with open('/home/axlefublr/r/dot/helix/quit.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['whitespace']['render']['newline'] = 'none'
entire_config['editor']['gutters']['layout'] = []
# entire_config['editor']['gutters-right']['layout'] = []
entire_config['keys']['normal'][':'] = ':quit-all!'
entire_config['keys']['select'][':'] = ':quit-all!'

# hotkeys that may write and close the current buffer now close entire helix without saving
with open('/home/axlefublr/r/dot/helix/man.toml', 'w') as file:
    toml.dump(entire_config, file)

entire_config['editor']['soft-wrap']['enable'] = False
entire_config['editor']['scrolloff'] = 0

# meant for using helix to view a screen; wrapping disabled because of the line ending characters
with open('/home/axlefublr/r/dot/helix/wrap-off.toml', 'w') as file:
    toml.dump(entire_config, file)
