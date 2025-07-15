Log into your firefox account.

# about:preferences

Configure home to be file:///home/axlefublr/fes/lai/annabirch/index.html
Lepton UI → Photon design
Enable shortcuts in address bar

# about:config

devtools.debugger.prompt-connection
devtools.inspector.remote
ui.key.menuAccessKeyFocuses
ui.key.menuAccessKey = -1
mousewheel.default.delta_multiplier_y = 200
floorp.newtab.overrides.newtaburl = file:///home/axlefublr/fes/lai/annabirch/index.html

# css

`~/.floorp/93ml3dbj.default-release-1` is more or less how your profile directory will look like
```sh
rm -fr ~/.floorp/93ml3dbj.default-release-1/chrome
ln -sf ~/fes/dot/floorp ~/.floorp/93ml3dbj.default-release-1/chrome
```

# foxyproxy

Give all permissions it's asking for, including running in private windows.
Import `~/fes/eli/foxyproxy.json`.

You still need to configure the base browser proxy settings to use your http proxy (manual proxy configuration).

# extensions

Hotkeys for ublock origin zapper and selector.
Hotkey to toggle dark reader.
Import stylus styles one by one.

# discord

## appearance

Chat font scaling to 18

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
