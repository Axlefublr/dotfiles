Add ↓ to /usr/share/applications/floorp.desktop
```
MOZ_ENABLE_WAYLAND=1
```

Log into your firefox account.

# about:preferences

Configure home to be file:///home/axlefublr/fes/lai/annabirch/index.html
Lepton UI → Photon design
Enable shortcuts in address bar
Don't force sleep discord.com and web.telegram.org

# about:config

devtools.debugger.prompt-connection
devtools.inspector.remote
ui.key.menuAccessKeyFocuses
ui.key.menuAccessKey = -1
mousewheel.default.delta_multiplier_y = 200
floorp.newtab.overrides.newtaburl = file:///home/axlefublr/fes/lai/annabirch/index.html
toolkit.zoomManager.zoomValues = 0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3.0

was: .3,.5,.67,.8,.9,1,1.1,1.2,1.33,1.5,1.7,2,2.4,3,4,5

# css

`~/.floorp/93ml3dbj.default-release-1` is more or less how your profile directory will look like
```sh
rm -fr ~/.floorp/93ml3dbj.default-release-1/chrome
ln -sf ~/fes/dot/floorp ~/.floorp/93ml3dbj.default-release-1/chrome
```

# foxyproxy

Give all permissions it's asking for, including running in private windows.
Import `~/fes/eli/foxyproxy.json`.
You don't need to set the in-browser proxy settings, keep them as “no proxy”.

# extensions

Hotkeys for ublock origin zapper and selector.
Hotkey to toggle dark reader.
Import stylus styles one by one.

# discord

## appearance

Chat font scaling to 18

## chat

Open threads in split view — disable

# custom shortcuts

```
floorp.custom.shortcutkeysAndActions.customAction
```

`^!'` to focus main page after focusing address bar
```js
document.querySelector("browser[primary='true']").focus()
```

Moving the current tab to the next / previous workspace
```js
(async () => {
    const currentTab = window.gBrowser.selectedTab;
    const workspaces = await gWorkspaces.getAllWorkspacesId();
    const current = await gWorkspaces.getCurrentWorkspaceId();
    const currentIndex = workspaces.indexOf(current);
    let destinationIndex = currentIndex - 1;
    if (destinationIndex >= workspaces.length) {
        destinationIndex = 0;
    }
    const destination = workspaces.at(destinationIndex);
    await gWorkspaces.changeWorkspace(destination, null, false, true);
})();
```

Moving just *you* to the next / previous workspace
```js
(async () => {
    const workspaces = await gWorkspaces.getAllWorkspacesId();
    const current = await gWorkspaces.getCurrentWorkspaceId();
    const currentIndex = workspaces.indexOf(current);
    let destinationIndex = currentIndex - 1;
    if (destinationIndex >= workspaces.length) {
        destinationIndex = 0;
    }
    const destination = workspaces.at(destinationIndex);
    await gWorkspaces.changeWorkspace(destination, null, false, false);
})();
```
