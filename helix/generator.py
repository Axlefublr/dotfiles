#!/usr/bin/env python3

import sys  # noqa: F401
from typing import Any

import toml

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
        'file-name',
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
    'auto-signature-help': True,
    'display-inlay-hints': True,
    'display-signature-help-docs': True,
    'goto-reference-include-declaration': False,
}

editor: dict[str, Any] = {
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
        'render': {'newline': 'all', 'tab': 'all'},
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
            'diff',
            # 'spacer',
        ],
    },
    'statusline': statusline,
    'lsp': lsp,
}


def disable(mappings: list[str]) -> dict[str, str]:
    return {item: 'no_op' for item in mappings}


def transform(char: str):
    to_russian = {
        'q': 'й',
        'w': 'ц',
        'e': 'у',
        'r': 'к',
        't': 'е',
        'y': 'н',
        'u': 'г',
        'i': 'ш',
        'o': 'щ',
        'p': 'з',
        '[': 'х',
        ']': 'ъ',
        'a': 'ф',
        's': 'ы',
        'd': 'в',
        'f': 'а',
        'g': 'п',
        'h': 'р',
        'j': 'о',
        'k': 'л',
        'l': 'д',
        ';': 'ж',
        "'": 'э',
        'z': 'я',
        'x': 'ч',
        'c': 'с',
        'v': 'м',
        'b': 'и',
        'n': 'т',
        'm': 'ь',
        ',': 'б',
        '.': 'ю',
        'Q': 'Й',
        'W': 'Ц',
        'E': 'У',
        'R': 'К',
        'T': 'Е',
        'Y': 'Н',
        'U': 'Г',
        'I': 'Ш',
        'O': 'Щ',
        'P': 'З',
        '{': 'Х',
        '}': 'Ъ',
        'A': 'Ф',
        'S': 'Ы',
        'D': 'В',
        'F': 'А',
        'G': 'П',
        'H': 'Р',
        'J': 'О',
        'K': 'Л',
        'L': 'Д',
        ':': 'Ж',
        '"': 'Э',
        'Z': 'Я',
        'X': 'Ч',
        'C': 'С',
        'V': 'М',
        'B': 'И',
        'N': 'Т',
        'M': 'Ь',
        '<': 'Б',
        '>': 'Ю',
    }
    new_key = to_russian.get(char)
    if new_key is not None:
        return new_key
    if char.startswith('A-') or char.startswith('C-'):
        subkey = to_russian.get(char[2:])
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
    'h': 'move_char_left',
    'l': 'move_char_right',
    'x': 'select_mode',
    'r': ['collapse_selection', 'replace'],
    'j': 'move_visual_line_down',
    'k': 'move_visual_line_up',
    '`': ['collapse_selection', 'switch_to_lowercase'],
    'A-`': ['collapse_selection', 'switch_to_uppercase'],
    '~': ['collapse_selection', 'switch_case'],
}

normal_mappings.update(**rusify(normal_mappings))

select_mappings: dict[str, Any] = {
    'h': 'extend_char_left',
    'l': 'extend_char_right',
    'A-i': 'extend_parent_node_start',
    'A-o': 'extend_parent_node_end',
    'x': 'normal_mode',
    'j': 'extend_visual_line_down',
    'k': 'extend_visual_line_up',
}
select_mappings.update(**rusify(select_mappings))

insert_mappings: dict[str, Any] = {
    "A-'": 'insert_register',
    'C-v': ['collapse_selection', 'paste_clipboard_before'],
    'A-/': ':xa!',
    'C-j': ['normal_mode', 'open_below'],
    'C-k': ['normal_mode', 'open_above'],
    'A-,': 'unindent',
    'A-.': 'indent',
    'C-ц': ['normal_mode', 'move_prev_word_start', 'change_selection'],
    'C-u': 'kill_to_line_start',
}
insert_mappings.update(**rusify(insert_mappings))

normal_insert_mappings: dict[str, Any] = {
    'A-i': 'move_parent_node_start',
    'A-o': 'move_parent_node_end',
}
normal_insert_mappings.update(**rusify(normal_insert_mappings))
normal_mappings.update(**normal_insert_mappings)
insert_mappings.update(**normal_insert_mappings)

magazine_openers: dict[str, Any] = {
    # TODO: magazine openers
    'q': ':open ~/.local/share/magazine/q',
    'w': ':open ~/.local/share/magazine/w',
    'e': ':open ~/.local/share/magazine/e',
    'r': ':open ~/.local/share/magazine/r',
    't': ':open ~/.local/share/magazine/t',
    'y': ':open ~/.local/share/magazine/y',
    'u': ':open ~/.local/share/magazine/u',
    'i': ':open ~/.local/share/magazine/i',
    'o': ':open ~/.local/share/magazine/o',
    'p': ':open ~/.local/share/magazine/p',
    'a': ':open ~/.local/share/magazine/a',
    's': ':open ~/.local/share/magazine/s',
    'd': ':open ~/.local/share/magazine/d',
    'f': ':open ~/.local/share/magazine/f',
    'g': ':open ~/.local/share/magazine/g',
    'h': ':open ~/.local/share/magazine/h',
    'j': ':open ~/prog/dotfiles/project.txt',
    'k': ':open ~/.local/share/magazine/k',
    'l': ':open ~/.local/share/magazine/l',
    'z': ':open ~/.local/share/magazine/z',
    'x': ':open ~/.local/share/magazine/x',
    'c': ':open ~/.local/share/magazine/c',
    'v': ':open ~/.local/share/magazine/v',
    'b': ':open ~/.local/share/magazine/b',
    'n': ':open ~/.local/share/magazine/n',
    'm': ':open ~/.local/share/magazine/m',
    'Q': ':open ~/.local/share/magazine/Q',
    'W': ':open ~/.local/share/magazine/W',
    'E': ':open ~/.local/share/magazine/E',
    'R': ':open ~/.local/share/magazine/R',
    'T': ':open ~/.local/share/magazine/T',
    'Y': ':open ~/.local/share/magazine/Y',
    'U': ':open ~/.local/share/magazine/U',
    'I': ':open ~/.local/share/magazine/I',
    'O': ':open ~/.local/share/magazine/O',
    'P': ':open ~/.local/share/magazine/P',
    'A': ':open ~/.local/share/magazine/A',
    'S': ':open ~/.local/share/magazine/S',
    'D': ':open ~/.local/share/magazine/D',
    'F': ':open ~/.local/share/magazine/F',
    'G': ':open ~/.local/share/magazine/G',
    'H': ':open ~/.local/share/magazine/H',
    'J': ':open project.txt',
    'K': ':open ~/.local/share/magazine/K',
    'L': ':open ~/.local/share/magazine/L',
    'Z': ':open ~/.local/share/magazine/Z',
    'X': ':open ~/.local/share/magazine/X',
    'C': ':open ~/.local/share/magazine/C',
    'V': ':open ~/.local/share/magazine/V',
    'B': ':open ~/.local/share/magazine/B',
    'N': ':open ~/.local/share/magazine/N',
    'M': ':open ~/.local/share/magazine/M',
    '0': ':open ~/.local/share/magazine/0',
    '1': ':open ~/.local/share/magazine/1',
    '2': ':open ~/.local/share/magazine/2',
    '3': ':open ~/.local/share/magazine/3',
    '4': ':open ~/.local/share/magazine/4',
    '5': ':open ~/.local/share/magazine/5',
    '6': ':open ~/.local/share/magazine/6',
    '7': ':open ~/.local/share/magazine/7',
    '8': ':open ~/.local/share/magazine/8',
    '9': ':open ~/.local/share/magazine/9',
}

normal_select_mappings: dict[str, Any] = {
    'A-,': 'decrement',
    'A-.': 'increment',
    'o': 'open_below',
    'O': 'open_above',
    'H': 'page_cursor_half_up',
    'L': 'page_cursor_half_down',
    'ret': 'command_mode',
    ',': 'flip_selections',
    'G': 'goto_word',
    'A-;': 'ensure_selections_forward',
    '+': 'remove_primary_selection',
    'J': 'keep_primary_selection',
    'X': 'join_selections',
    'V': 'extend_line_above',
    'v': 'extend_line_below',
    'D': ['delete_selection', 'move_char_left'],
    ':': 'repeat_last_motion',
    '$': 'keep_selections',
    'K': ':xa!',
    "'": ':wa!',
    'M': 'save_selection',
    'A-h': 'select_prev_sibling',
    'A-l': 'select_next_sibling',
    'C-n': 'shrink_selection',
    'A-j': 'shrink_selection',
    'C-p': 'expand_selection',
    'A-k': 'expand_selection',
    '\\': ['select_all', 'delete_selection_noyank', 'shell_append_output'],
    '{': 'goto_prev_paragraph',
    '}': 'goto_next_paragraph',
    '#': 'toggle_comments',
    'i': ['collapse_selection', 'insert_mode'],
    'a': ['collapse_selection', 'append_mode'],
    'C-j': ['normal_mode', 'open_below'],
    'C-k': ['normal_mode', 'open_above'],
    's': 'yank',
    'S': 'yank_to_clipboard',
    'y': 'select_regex',
    'Y': 'split_selection',
    'A-s': 'select_all',
    'A-m': 'split_selection_on_newline',
    'A-p': ':sh over lazygit &>/dev/null',
    'space': {
        'T': ':tree-sitter-scopes',
        't': ':tree-sitter-highlight-name',
        'f': 'file_picker_in_current_directory',
        'j': 'file_picker_in_current_buffer_directory',
        'e': 'buffer_picker',
        'K': ':qa!',
        'c': 'code_action',
        '?': 'command_palette',
        'd': magazine_openers,
        '$': 'shell_keep_pipe',
        **disable(['D', 'w', 'C', 'Y', 'p', 'P', 'G', 'a', 'g', 'b', 'A-c', 'h', 'F', 'y']),
    },
    'g': {
        'e': 'move_next_sub_word_end',
        'w': 'move_next_sub_word_start',
        # '': 'move_prev_sub_word_end',
        'b': 'move_prev_sub_word_start',
        'h': 'goto_first_nonwhitespace',
        'H': 'goto_line_start',
        'l': 'goto_line_end',
        'L': 'goto_line_end_newline',
        'm': 'goto_last_accessed_file',
        'M': 'goto_last_modified_file',
        'o': 'goto_file_end',
        'i': 'goto_file_start',
        '$': 'remove_selections',
        'X': 'join_selections_space',
        'u': 'goto_reference',
        'U': 'select_references_to_symbol_under_cursor',
        'g': ':reset-diff-change',
        **disable(['D', 't', 'c', 'r', 's', 'a']),
    },
    'z': {
        '/': 'make_search_word_bounded',
        'k': 'rotate_view_reverse',
        'j': 'rotate_view',
        'J': 'hsplit',
        'K': ':hsplit-new',
        ';': 'wclose',
        ':': ':new',
        'u': 'transpose_view',
        'o': 'wonly',
        'h': ['collapse_selection', 'extend_to_first_nonwhitespace'],
        'H': ['collapse_selection', 'extend_to_line_start'],
        'l': ['collapse_selection', 'extend_to_line_end'],
        'L': ['collapse_selection', 'extend_to_line_end_newline'],
        'M': 'merge_consecutive_selections',
        'm': 'merge_selections',
        ',': ':sort',
        '<': ':rsort',
        'i': 'insert_mode',
        'a': 'append_mode',
        'n': 'select_all_siblings',
        'N': 'select_all_children',
        "'": ':reload',
        **disable(
            [
                'z',
                'c',
                't',
                'b',
                'up',
                'down',
                'pageup',
                'pagedown',
                'C-b',
                'C-f',
                'C-u',
                'C-d',
                'backspace',
                'space',
                '?',
            ]
        ),
    },
    **disable(['Z', 'C-s', 'C-c', 'left', 'right', 'up', 'down', 'A-:']),
}
normal_select_mappings.update(**rusify(normal_select_mappings))
normal_mappings.update(**normal_select_mappings)
select_mappings.update(**normal_select_mappings)

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

entire_config['editor']['whitespace']['render']['newline'] = 'none'
entire_config['editor']['soft-wrap']['enable'] = False

with open('/home/axlefublr/prog/dotfiles/helix/wrap-off.toml', 'w') as file:
    toml.dump(entire_config, file)
