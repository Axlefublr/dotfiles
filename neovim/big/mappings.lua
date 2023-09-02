Map("v", "*", function() Search_for_selection('/', '') end)
Map("v", ",*", function() Search_for_selection('/', '/e') end)
Map("v", "#", function() Search_for_selection('?', '') end)
Map("v", ",#", function() Search_for_selection('?', '?e') end)

Map("", ",f", function() Search_for_register('/', '') end)
Map("", ",F", function() Search_for_register('?', '') end)
Map("", ",,f", function() Search_for_register('/', '/e') end)
Map("", ",,F", function() Search_for_register('?', '?e') end)

Map("n", ",g", Move_default_to_other)

Map("n", "*", function() Search_for_current_word('/', '') end)
Map("n", ",*", function() Search_for_current_word('/', '/e') end)
Map("n", "#", function() Search_for_current_word('?', '') end)
Map("n", ",#", function() Search_for_current_word('?', '?e') end)