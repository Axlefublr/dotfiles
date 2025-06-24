# This file is loaded after env.nu and before login.nu
# [[sort on]]
$env.PROMPT_COMMAND_RIGHT = ''
$env.PROMPT_INDICATOR = ' 󱕅 '
$env.PROMPT_MULTILINE_INDICATOR = '▌'
$env.config.buffer_editor = 'hx'
$env.config.history = { file_format: sqlite max_size: 1_000_000 sync_on_enter: true isolation: true }
$env.config.show_banner = false
const NU_LIB_DIRS = [ '~/fes/dot/nu/blue' ]
