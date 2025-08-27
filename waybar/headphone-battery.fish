#!/usr/bin/env fish

# mac codes discovered via `bluetoothctl` → `devices Connected`
begin
    busctl get-property org.bluez /org/bluez/hci0/dev_F4_9D_8A_18_05_B5 org.bluez.Battery1 Percentage
    or busctl get-property org.bluez /org/bluez/hci0/dev_68_D6_ED_18_9A_56 org.bluez.Battery1 Percentage
end | cut -d ' ' -f 2
