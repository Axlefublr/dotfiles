ya = {}

---@alias InputPositionAnchor
---| 'top-left'
---| 'top-center'
---| 'top-right'
---| 'bottom-left'
---| 'bottom-center'
---| 'bottom-right'
---| 'center'
---| 'hovered'

---@class InputPosition
---@field [1] InputPositionAnchor
---@field x integer? offset from origin position
---@field y integer? offset from origin position
---@field w integer
---@field h integer?

---@class InputOpts
---@field title string
---@field value string? the default value in the inputbox
---@field position InputPosition
---@field realtime boolean? report user input in real time
---@field debounce number? the number of seconds to wait for the user to stop typing (float). Can only be used when `realtime = true`

---@alias InputEvent
---| 0 unknown error
---| 1 user confirmed input
---| 2 user cancelled input
---| 3 user changed input (only if `realtime` is true)

---@param opts InputOpts
---@return string?, InputEvent
---When `realtime = true` specified, `ya.input()` returns a receiver, which has a `recv()` method that can be called multiple times to receive events.
function ya.input(opts) return '', 0 end

---@alias LogLevel
---| 'info'
---| 'warn'
---| 'error'

---@class NotifyOpts
---@field title string
---@field content string
---@field timeout number
---@field level LogLevel? is `'info'` by default

---@alias Sendable
---| nil
---| boolean
---| number
---| string
---| [Sendable]
---| table<string|number, Sendable>

---@param opts NotifyOpts
function ya.notify(opts) end

---@alias ManagerCommands
---| 'cd'

---@param cmd ManagerCommands
---@param args table<string|number, Sendable>
function ya.manager_emit(cmd, args) end

---@param func fun():any?
function ya.sync(func)
	return function() end
end

---@class Url

---@param url string
---@return Url
function Url(url)
	return {} --[[@as Url]]
end

---@class FolderFolder
---@field cwd Url

---@class TabTab
---@field current FolderFolder

cx = {
	---@type TabTab
	active = {
		---@type FolderFolder
		current = {
			cwd = {} --[[@as Url]],
		},
	},
}

---@class Status
---@field success boolean
---@field code Exitcode

---@class Output
---@field status Status
---@field stdout string
---@field stderr string

---@alias Exitcode integer

---@class Command
---@field args (fun(self:Command, args: string[]):Command) append multiple arguments to the command
---@field output (fun(self:Command):(Output?, Exitcode)) spawn the command and wait for it to finish

---@param cmd string
---@return Command
function Command(cmd)
	---@diagnostic disable-next-line: missing-fields
	return {} --[[@as Command]]
end
