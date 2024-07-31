return {
	s({ filetype = 'markdown', trig = 'inl' }, {
		t('['),
		i(1),
		t(']('),
		i(2),
		t(')'),
	}),
	s({ filetype = 'markdown', trig = 'kbd' }, { t('<kbd>'), i(1), t('</kbd>'), i(0) }),
}
