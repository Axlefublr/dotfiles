local function seek_to(side)
    local point = mp.get_property_number("ab-loop-" .. side, -1)
    if point and point >= 0 then
        mp.commandv("seek", point, "absolute+exact")
    else
        mp.osd_message("Empty " .. side .. " point")
    end
end
mp.add_key_binding(nil, "seek-tubh", function() seek_to('b') end)
mp.add_key_binding(nil, "seek-tuah", function() seek_to('a') end)
