---@diagnostic disable: undefined-global
return {
	s({ filetype = 'gitcommit', trig = 'v' }, { t('nvim: ') }),
	s({ filetype = 'gitcommit', trig = 'c' }, fmta('chore<>: ', { i(1) })),
	s({ filetype = 'gitcommit', trig = 'f' }, fmta('feat<>: ', { i(1) })),
	s({ filetype = 'gitcommit', trig = 'x' }, fmta('fix<>: ', { i(1) })),
	s({ filetype = 'gitcommit', trig = 'd' }, fmta('doc<>: ', { i(1) })),
	s({ filetype = 'gitcommit', trig = 'fi' }, { t('fish: ') }),
	s({ filetype = 'gitcommit', trig = 'awm' }, { t('awesome: ') }),
	s({ filetype = 'gitcommit', trig = 'cps' }, { t('compose: ') }),
	s({ filetype = 'gitcommit', trig = 'xr' }, { t('xremap: ') }),
	s({ filetype = 'gitcommit', trig = 'sty' }, { t('stylus(youtube): ') }),
	s({ filetype = 'gitcommit', trig = 'std' }, { t('stylus(discord): ') }),
	s({ filetype = 'gitcommit', trig = 'kit' }, { t('kitty: ') }),
	s({ filetype = 'gitcommit', trig = 'pkg' }, { t('pkg: ') }),
}
