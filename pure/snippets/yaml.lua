return {
	s({ filetype = 'yaml', trig = '!' }, { t('Alt-') }),
	s({ filetype = 'yaml', trig = '+' }, { t('Shift-') }),
	s({ filetype = 'yaml', trig = '^' }, { t('Ctrl-') }),
	s({ filetype = 'yaml', trig = '#' }, fmta('Super<>-<>', { i(1), i(2) })),
	s({ filetype = 'yaml', trig = 'apo' }, { t('Apostrophe') }),
	s({ filetype = 'yaml', trig = ';' }, { t('Semicolon') }),
	s({ filetype = 'yaml', trig = 'c' }, { t('CapsLock') }),
	s({ filetype = 'yaml', trig = 'lb' }, { t('LeftBrace') }),
	s({ filetype = 'yaml', trig = 'rb' }, { t('RightBrace') }),
	s({ filetype = 'yaml', trig = '\\' }, { t('Backslash') }),
	s({ filetype = 'yaml', trig = ',' }, { t('Comma') }),
	s({ filetype = 'yaml', trig = 'launch' }, {
		t('{ launch: ['),
		i(0),
		t('] }'),
	}),
	s({ filetype = 'yaml', trig = 'sm' }, {
		t('{ set_mode: '),
		i(1, 'default'),
		t(' }'),
	}),
}
