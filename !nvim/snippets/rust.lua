return {
	s({ filetype = 'rust', trig = 'rbde' }, {
		t('Result<'),
		i(1, '()'),
		t(', Box<dyn Error>>'),
	}),
}
