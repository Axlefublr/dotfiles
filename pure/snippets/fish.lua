return {
	s(
		{ filetype = 'fish', trig = 'awm' },
			{ t('awesome-client '), }
		),
	s({ filetype = 'fish', trig = 'if' }, {
		t('if '),
		i(1),
		t({ '', '\t' }),
		i(2),
		t({ '', 'end' }),
	}),
	s({ filetype = 'fish', trig = '#!' }, {
		t({ '#!/usr/bin/env fish', '' }), -- {} in a t is a multiline text node, every separate string is its own line
	}),
	s({ filetype = 'fish', trig = 'fn' }, {
		t('function '),
		i(1),
		t({ '', '    ' }),
		i(0),
		t({ '', 'end' }),
	}),
	s({ filetype = 'fish', trig = 'fns' }, {
		t('function '),
		i(1),
		t({ '', '    ' }),
		i(0),
		t({ '', 'end', 'funcsave ' }),
		rep(1),
		t(' >/dev/null'),
	}),
	s({ filetype = 'fish', trig = 'ift' }, {
		t('if test '),
		i(1),
		t({ '', '    ' }),
		i(0),
		t({ '', 'end' }),
	}),
	s({ filetype = 'fish', trig = 'elseift' }, {
		t('else if test '),
		i(1),
		t({ '', '    ' }),
	}),
	s({ filetype = 'fish', trig = 'fcs' }, {
		t('funcsave '),
		i(0),
		t(' >/dev/null'),
	}),
	s({ filetype = 'fish', trig = 'while' }, {
		t('while '),
		i(1),
		t({ '', '    ' }),
		i(0),
		t({ '', 'end' }),
	}),
	s({ filetype = 'fish', trig = 'ali' }, {
		t('alias --save '),
		i(1),
		t(" '"),
		i(0),
		t("' >/dev/null"),
	}),
	s({ filetype = 'fish', trig = 'read' }, {
		t('read -p rdp'),
	}),
	s({ filetype = 'fish', trig = 'xcp' }, {
		t('xclip -r -selection clipboard'),
	}),
	s({ filetype = 'fish', trig = 'xpc' }, {
		t('xclip -selection clipboard -o'),
	}),
}
