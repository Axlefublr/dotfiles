---@diagnostic disable: undefined-global
return {

	s({ filetype = 'all', trig = 'shred' }, {
		t('ff2930'),
	}),
	s({ filetype = 'all', trig = 'shorange' }, {
		t('ff9f1a'),
	}),
	s({ filetype = 'all', trig = 'shyellow' }, {
		t('ffd75f'),
	}),
	s({ filetype = 'all', trig = 'shsalad' }, {
		t('87ff5f'),
	}),
	s({ filetype = 'all', trig = 'shgreen' }, {
		t('3dff47'),
	}),
	s({ filetype = 'all', trig = 'shcyan' }, {
		t('00d7ff'),
	}),
	s({ filetype = 'all', trig = 'shpurple' }, {
		t('af87ff'),
	}),
	s({ filetype = 'all', trig = 'shpink' }, {
		t('ffafd7'),
	}),
	s({ filetype = 'all', trig = 'shcoral' }, {
		t('ff8787'),
	}),
	s({ filetype = 'all', trig = 'shgrey' }, {
		t('878787'),
	}),
	s({ filetype = 'all', trig = 'shblack' }, {
		t('0f0f0f'),
	}),

	s({ filetype = 'all', trig = 'grred' }, {
		t('ea6962'),
	}),
	s({ filetype = 'all', trig = 'grorange' }, {
		t('e49641'),
	}),
	s({ filetype = 'all', trig = 'gryellow' }, {
		t('d3ad5c'),
	}),
	s({ filetype = 'all', trig = 'grgreen' }, {
		t('a9b665'),
	}),
	s({ filetype = 'all', trig = 'grmint' }, {
		t('78bf84'),
	}),
	s({ filetype = 'all', trig = 'grcyan' }, {
		t('7daea3'),
	}),
	s({ filetype = 'all', trig = 'grpurple' }, {
		t('b58cc6'),
	}),
	s({ filetype = 'all', trig = 'grblush' }, {
		t('e491b2'),
	}),
	s({ filetype = 'all', trig = 'grwhite' }, {
		t('d4be98'),
	}),
	s({ filetype = 'all', trig = 'grgrey' }, {
		t('928374'),
	}),
	s({ filetype = 'all', trig = 'grlight25' }, {
		t('403f3f'),
	}),
	s({ filetype = 'all', trig = 'grlight19' }, {
		t('313030'),
	}),
	s({ filetype = 'all', trig = 'grdark13' }, {
		t('212121'),
	}),
	s({ filetype = 'all', trig = 'grdark12' }, {
		t('1f1e1e'),
	}),
	s({ filetype = 'all', trig = 'grdark10' }, {
		t('1a1919'),
	}),
	s({ filetype = 'all', trig = 'grbg' }, {
		t('292828'),
	}),

	-- ╔══════════════════════════════════════════════════════════════════════╗
	-- ║ I do this silly concatenation so that grepping for the various todos ║
	-- ║ doesn't show the implementation unecessarily                         ║
	-- ╚══════════════════════════════════════════════════════════════════════╝
	s({ filetype = 'all', trig = 'td' }, { t('TO' .. 'DO: ') }),
	s({ filetype = 'all', trig = 'fx' }, { t('FI' .. 'XME: ') }),
	s({ filetype = 'all', trig = 'mov' }, { t('MO' .. 'VE: ') }),
}
