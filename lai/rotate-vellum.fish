#!/usr/bin/env -S fish -N

if vellum is-active
    if vellum is-whiteboard
        vellum deactivate
    else
        vellum whiteboard show
    end
else
    vellum activate
end
