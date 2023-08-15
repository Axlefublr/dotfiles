-- Code block
Map("v", "im", "aBV")
Map("v", "am", "aBVj")
Map("v", "iM", "aBVok")
Map("v", "aM", "aBVjok")
Map("o", "im", function() Cmd("normal vaBV") end)
Map("o", "am", function() Cmd("normal vaBVj") end)
Map("o", "iM", function() Cmd("normal vaBVok") end)
Map("o", "aM", function() Cmd("normal vaBVjok") end)

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