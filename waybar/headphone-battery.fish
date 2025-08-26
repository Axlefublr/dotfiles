#!/usr/bin/env fish

# mac codes discovered via `bluetoothctl` → `devices Connected`
set -l output (busctl get-property org.bluez /org/bluez/hci0/dev_F4_9D_8A_18_05_B5 org.bluez.Battery1 Percentage 2>/dev/null || busctl get-property org.bluez /org/bluez/hci0/dev_68_D6_ED_18_9A_56 org.bluez.Battery1 Percentage 2>/dev/null)
echo -n $output | cut -d ' ' -f 2
