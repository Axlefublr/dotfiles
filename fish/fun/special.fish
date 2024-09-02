#!/usr/bin/env fish

function edit-repo-root-or-cwd
    $EDITOR (git rev-parse --show-toplevel || echo $PWD)
end
funcsave edit-repo-root-or-cwd >/dev/null
