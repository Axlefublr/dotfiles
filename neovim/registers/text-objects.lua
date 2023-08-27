-- Code block
Map("v", "im", "iiok", { remap = true })
Map("v", "am", "iijok", { remap = true })
Map("v", "iM", "iio2k", { remap = true })
Map("v", "aM", "iijo2k", { remap = true })
Map("o", "im", function() Cmd("normal viiok") end)
Map("o", "am", function() Cmd("normal viijok") end)
Map("o", "iM", function() Cmd("normal viio2k") end)
Map("o", "aM", function() Cmd("normal viijo2k") end)

-- Percent sign %
Map("v", "i%", "T%ot%")
Map("v", "a%", "F%of%")
Map("o", "i%", function() Cmd("normal vT%ot%") end)
Map("o", "a%", function() Cmd("normal vF%of%") end)

-- Markdown heading
Map("v", "ir", "?^#<cr>oNk")
Map("v", "iR", "?^#<cr>koNk")

-- Exclusive previous / next blank line
Map({"n", "v"}, "<leader>}", "}k")
Map({"n", "v"}, "<leader>{", "{j")
Map("o", "<leader>}", function() Cmd("normal V}k") end)
Map("o", "<leader>{", function() Cmd("normal V{j") end)