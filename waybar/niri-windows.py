#!/bin/env python
# pyright: basic
# stolen from my friend denial: https://git.ficd.sh/ficd/niri-scripts/src/branch/main/windows/niri-windows.py

import json
import logging
import os
import socket
import sys
from typing import override

# Logging setup
log = logging.getLogger()
log.setLevel(logging.DEBUG)
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.DEBUG if 'NIRILOG' in os.environ else logging.ERROR)
log.addHandler(handler)

SOCKET = os.environ['NIRI_SOCKET']


# Models


class Window:
    """Represents a Niri window."""

    def __init__(
        self,
        id: int,
        title: str,
        app_id: str,
        layout: dict | None = None,
        is_focused: bool = False,
    ):
        self.id = id
        self.title = title
        self.app_id = app_id
        self.layout = layout
        self.is_focused = is_focused

    @override
    def __str__(self):
        return f'{self.app_id}: {self.title}'


class Workspace:
    """Represents a Niri workspace, tracks state."""

    def __init__(self, id: int, output: str):
        self.id = id
        self.output = output
        self.windows: dict[int, Window] = {}
        self.columns: set[int] = set()
        self.focused_column: int | None = None

    def update_columns(self):
        """Computes the active column and total columns in this workspace."""
        new_cols = set()
        for w in self.windows.values():
            pos = w.layout and w.layout.get('pos_in_scrolling_layout')
            if pos:
                new_cols.add(pos[0])
        self.columns = new_cols

    def add_window(self, w: Window):
        self.windows[w.id] = w

    def remove_window(self, win_id: int):
        self.windows.pop(win_id, None)

    def get_windows(self):
        return list(self.windows.values())

    def __str__(self):
        return str(list(self.windows))


# State Management
class State:
    """Overall Niri state. Tracks workspaces."""

    def __init__(self):
        self.focused_workspace: int = 0
        self.active_workspaces: dict[str, int] = {}
        self.workspaces: dict[int, Workspace] = {}

    def get_workspace(self, output: str | None = None) -> Workspace | None:
        ws_id = self.active_workspaces.get(output) if output else self.focused_workspace
        return self.workspaces.get(ws_id) if ws_id else None

    def update_workspaces(self, workspaces: list[dict]):
        """Takes a new list of 'canonical' workspaces and updates the internal list to match it."""
        current_ids = set()
        for ws_info in workspaces:
            ws_id = ws_info['id']
            output = ws_info['output']
            if ws_id not in self.workspaces:
                self.workspaces[ws_id] = Workspace(ws_id, output)
            if ws_info.get('is_focused'):
                self.focused_workspace = ws_id
            if ws_info.get('is_active'):
                self.active_workspaces[output] = ws_id
            current_ids.add(ws_id)
        # Drop removed workspaces
        for ws_id in list(self.workspaces.keys()):
            if ws_id not in current_ids:
                self.workspaces.pop(ws_id)

    def update_window(self, win: dict):
        """Takes a window, finds it by ID in internal tracking and updates its attributes."""
        ws_id = win['workspace_id']
        w = Window(
            id=win['id'],
            title=win.get('title') or '',
            app_id=win.get('app_id') or '',
            layout=win.get('layout'),
            is_focused=win.get('is_focused', False),
        )
        if ws_id in self.workspaces:
            self.workspaces[ws_id].add_window(w)

    def remove_window(self, win_id: int):
        for ws in self.workspaces.values():
            if win_id in ws.windows:
                ws.remove_window(win_id)
                break

    def refresh_layout_state(self):
        """Update column information for all workspaces."""
        for ws in self.workspaces.values():
            ws.update_columns()
        self.update_focused_column()

    def update_focused_column(self):
        for ws in self.workspaces.values():
            ws.focused_column = None
            for w in ws.windows.values():
                if w.is_focused:
                    pos = w.layout and w.layout.get('pos_in_scrolling_layout')
                    if pos:
                        ws.focused_column = pos[0]


state = State()


# Rendering
def generate_tooltip(output=None) -> str:
    """Generates tooltip for Waybar in JSON format."""
    ws = state.get_workspace(output)
    if not ws:
        return ''
    return '\r\n'.join(map(str, ws.get_windows()))


def generate_text(output=None) -> str:
    """Generates display text for Waybar in JSON format."""
    ws = state.get_workspace(output)
    if not ws:
        return ''
    ws.update_columns()
    icons = [
        '' if ws.focused_column == col else ''  # 
        for col in sorted(ws.columns)
    ]
    if log.isEnabledFor(logging.DEBUG):
        log.debug(state)
    return ' '.join(icons)


def display():
    """Prints the final JSON payload for Waybar."""
    print(
        json.dumps(
            {'text': generate_text(), 'tooltip': generate_tooltip()},
            ensure_ascii=False,
        ),
        flush=True,
    )


# Event Handling
def handle_message(event: dict) -> bool:
    """Handle events from Niri stream."""
    if not event:
        return False
    event_type = next(iter(event))
    payload = event[event_type]
    should_display = False

    match event_type:
        case 'WorkspacesChanged':
            state.update_workspaces(payload['workspaces'])
            should_display = True

        case 'WindowsChanged':
            for win in payload['windows']:
                state.update_window(win)
            state.refresh_layout_state()
            should_display = True

        case 'WorkspaceActivated':
            if payload.get('focused'):
                state.focused_workspace = payload['id']
            state.active_workspaces[state.workspaces[payload['id']].output] = payload['id']
            should_display = True

        case 'WindowOpenedOrChanged':
            win = payload['window']
            state.remove_window(win['id'])
            state.update_window(win)
            state.refresh_layout_state()
            should_display = True

        case 'WindowClosed':
            state.remove_window(payload['id'])
            state.refresh_layout_state()
            should_display = True

        case 'WindowFocusChanged':
            focused_id = payload['id']
            for ws in state.workspaces.values():
                for w in ws.windows.values():
                    w.is_focused = w.id == focused_id
            state.update_focused_column()
            should_display = True

        case 'WindowLayoutsChanged':
            for win_id, layout in payload['changes']:
                for ws in state.workspaces.values():
                    if win_id in ws.windows:
                        ws.windows[win_id].layout = layout
            state.refresh_layout_state()
            should_display = True

        case _:
            log.debug(f'Ignoring unknown event: {event_type}')

    return should_display


# Socket Loop
def server():
    """Connect to Niri socket and begin loop of reading events."""
    log.info(f'Connecting to Niri socket @ {SOCKET}')
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as client:
        client.connect(SOCKET)
        client.sendall(b'"EventStream"\n')
        client.shutdown(socket.SHUT_WR)

        log.info('Connected; listening for events.')
        while True:
            data = client.recv(4096)
            if not data:
                continue
            for line in data.split(b'\n'):
                if not line.strip():
                    continue
                try:
                    event = json.loads(line)
                    if handle_message(event):
                        display()
                except json.JSONDecodeError:
                    log.error(
                        'Malformed JSON: %s',
                        line.decode(errors='replace'),
                    )


def main():
    try:
        server()
    except Exception as e:
        log.error('Fatal error: %s', e)
        print(e, flush=True)


if __name__ == '__main__':
    main()
