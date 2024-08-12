return {
	s({ filetype = 'html', trig = 'cc' }, {
		t('{{c1::'),
		i(1),
		t('}}'),
	}),
	s({ filetype = 'html', trig = 'cda' }, {
		t({ '<div class="codeblock above">', '\t' }),
		i(0),
		t({ '', '</div>' }),
	}),
	s({ filetype = 'html', trig = 'cdb' }, {
		t({ '<div class="codeblock below">', '\t' }),
		i(0),
		t({ '', '</div>' }),
	}),
}
