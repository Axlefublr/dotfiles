-- Russian layout support
local ru_keys = {
	'й', 'ц', 'у', 'к', 'е', 'н', 'г', 'ш', 'щ', 'з', 'х', 'ъ',
	'ф', 'ы', 'в', 'а', 'п', 'р', 'о', 'л', 'д', 'ж', 'э',
	'я', 'ч', 'с', 'м', 'и', 'т', 'ь', 'б', 'ю',
	'Й', 'Ц', 'У', 'К', 'Е', 'Н', 'Г', 'Ш', 'Щ', 'З', 'Х', 'Ъ',
	'Ф', 'Ы', 'В', 'А', 'П', 'Р', 'О', 'Л', 'Д', 'Ж', 'Э',
	'Я', 'Ч', 'С', 'М', 'И', 'Т', 'Ь', 'Б', 'Ю'
}
local en_keys = {
	'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']',
	'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'',
	'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.',
	'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}',
	'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"',
	'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>',
}
for i = 1, #ru_keys do
	vim.api.nvim_set_keymap('n', ru_keys[i], en_keys[i], { noremap = false })
	vim.api.nvim_set_keymap('v', ru_keys[i], en_keys[i], { noremap = false })
	vim.api.nvim_set_keymap('o', ru_keys[i], en_keys[i], { noremap = false })
end