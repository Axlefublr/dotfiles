ya = {}

---@alias YaInputPositionRelativity
---| 'top-left'
---| 'top-center'
---| 'top-right'
---| 'bottom-left'
---| 'bottom-center'
---| 'bottom-right'
---| 'center'
---| 'hovered'

---@class YaInputPosition
---@field [1] YaInputPositionRelativity
---@field x integer? offset from origin position
---@field y integer? offset from origin position
---@field w integer
---@field h integer?

---@class YaInputOpts
---@field title string
---@field value string? the default value in the inputbox
---@field position YaInputPosition
---@field realtime boolean? report user input in real time
---@field debounce number? the number of seconds to wait for the user to stop typing (float). Can only be used when `realtime = true`

---@alias YaInputEvent
---| 0 unknown error
---| 1 user confirmed input
---| 2 user cancelled input
---| 3 user changed input (only if `realtime` is true)

---@param opts YaInputOpts
---@return string?, YaInputEvent
---When `realtime = true` specified, `ya.input()` returns a receiver, which has a `recv()` method that can be called multiple times to receive events.
function ya.input(opts) return '', 0 end
