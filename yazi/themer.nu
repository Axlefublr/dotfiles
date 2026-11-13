#!/usr/bin/env -S nu -n --no-std-lib

const self = path self
const red = '#ea6962'
const orange = '#e49641'
const yellow = '#d3ad5c'
const green = '#a9b665'
const mint = '#78bf84'
const cyan = '#7daea3'
const purple = '#b58cc6'
const blush = '#e491b2'
const grey = '#928374'
const dark12 = '#1f1f1f'
const dark13 = '#212121'

let config = {
	mgr: {
		count_copied:    { bg: $blush, fg: $dark12, bold: true }
		count_cut:       { bg: $red, fg: $dark12, bold: true }
		count_selected:  { bg: $yellow, fg: $dark12, bold: true }
		cwd:             { fg: '#ffafd7',                bold: true }
		find_keyword:    { fg: $red,                bold: true }
		find_position:   { fg: $red,                bold: true }
		marker_copied:   { bg: $blush, fg: $blush }
		marker_cut:      { bg: $red, fg: $red }
		marker_marked:   { bg: $orange, fg: $orange }
		marker_selected: { bg: $yellow, fg: $yellow }
	}
	tabs: {
		active:   { fg: white, bold: true }
		inactive: { fg: $grey }
	}
	mode: {
		normal_alt:  { fg: white, bg: reset }
		normal_main: { fg: white, bg: reset }
		select_alt:  { fg: white, bg: reset }
		select_main: { fg: white, bg: reset }
		unset_alt:   { fg: white, bg: reset }
		unset_main:  { fg: white, bg: reset }
	}
	indicator: {
		padding: { open: '█', close: '█', }
	}
	status: {
		perm_sep:        { fg: $grey }
		progress_error:  { fg: $red }
		progress_label:  { fg: $dark12, bold: true }
		progress_normal: { fg: $green }
		sep_left:        { open: '', close: '' }
		sep_right:       { open: '', close: '' }
	}
	which: {
		cols: 2
		separator: ' → '
		mask: { bg: $dark13 }
		separator_style: { fg: white }
		cand: { fg: $orange }
		desc: { fg: $yellow }
	}
	confirm: {
		border: { fg: $orange, bold: true }
		title: { fg: $orange }
		btn_yes: {}
		btn_labels: [ Yes, No ]
	}
	spot: {
		border: { fg: $orange, bold: true }
		title: { fg: $orange }
		tbl_col: { fg: $purple }
		tbl_cell: { reversed: true }
	}
	notify: {
		title_info: { fg: $cyan }
		title_warn: { fg: $orange }
		title_error: { fg: red }
	}
	pick: {
		border: { fg: $orange, bold: true }
		active: { reversed: true }
		inactive: { fg: $purple }
	}
	input: {
		border: { fg: $orange, bold: true }
		title: { fg: $orange, bold: true }
	}
	tasks: {
		border: { fg: $orange, bold: true }
		title: { fg: $orange, bold: true }
		hovered: { reversed: true }
	}
	help: {
		border: { fg: $orange, bold: true }
		title: { fg: $orange, bold: true }
		on: { fg: $orange }
		run: { fg: $yellow }
		hovered: { bg: '#4d4d4d' }
		footer: { fg: white }
	}
	filetype: {
		rules: [
			{ mime: inode/empty ,             fg: red }
			{ url: *            , is: orphan, fg: red }
			{ url: *            , is: fifo  , fg: $blush }
			{ url: *            , is: link  , fg: $mint }
			{ url: *            , is: exec  , fg: green }
			{ mime: folder/local,             fg: $purple }
		]
	}
	icon: {
		dirs: {
			# [[sort on]]
			: [['.npm']]
			: [['.git']]
			: [['.config']]
			: [['.github']]
			# [[sort off]]
		}
		files: {
			: [['.bash_profile', '.bashrc', '.clang-format', '.clang-tidy', '.ds_store', '.luacheckrc', '.luaurc', '.pylintrc', '.zprofile', '.zshenv', '.zshrc', config, 'Directory.Build.props', 'Directory.Build.targets', 'Directory.Packages.props', gnumakefile, makefile, mk, Jenkinsfile]]
			󰊢: [['.git-blame-ignore-revs', '.gitattributes', '.gitignore', '.gitmodules', commit_editmsg, '.gitconfig', '.mailmap']]
			# [[sort on]]
			: [['py.typed'], '#ffbc03']
			: [[procfile]]
			: [[copying, 'copying.lesser', license, 'license.md', unlicense]]
			: [['gulpfile.babel.js', 'gulpfile.coffee', 'gulpfile.js', 'gulpfile.ts']]
			: [['gruntfile.babel.js', 'gruntfile.coffee', 'gruntfile.js', 'gruntfile.ts']]
			: [['favicon.ico']]
			: [['go.mod', 'go.sum', 'go.work'], '#00add8']
			: [['.gvimrc', '.vimrc', _gvimrc, _vimrc]]
			: [['mix.lock']]
			: [['.babelrc']]
			: [[build, workspace]]
			: [['.editorconfig']]
			: [['.eslintignore', '.eslintrc', 'eslint.config.cjs', 'eslint.config.js', 'eslint.config.mjs', 'eslint.config.ts']]
			: [['build.gradle', 'gradle-wrapper.properties', 'gradle.properties', gradlew, 'settings.gradle']]
			: [['pom.xml']]
			: [['platformio.ini']]
			: [['prisma.config.mts', 'prisma.config.ts']]
			: [['svelte.config.js']]
			: [['build.zig.zon']]
			: [['.prettierignore', '.prettierrc', '.prettierrc.cjs', '.prettierrc.js', '.prettierrc.json', '.prettierrc.json5', '.prettierrc.mjs', '.prettierrc.toml', '.prettierrc.yaml', '.prettierrc.yml', 'prettier.config.cjs', 'prettier.config.js', 'prettier.config.mjs', 'prettier.config.ts']]
			: [['.settings.json']]
			: [['.condarc']]
			: [['.nvmrc', node_modules]]
			: [['.npmignore', '.npmrc', 'package-lock.json', 'package.json']]
			: [['bun.lock', 'bun.lockb']]
			: [['ext_typoscript_setup.txt']]
			: [[groovy]]
			: [[brewfile, Gemfile, rakefile]]
			: [['wrangler.jsonc', 'wrangler.toml']]
			: [['cmakelists.txt']]
			: [['ionic.config.json']]
			: [['.nanorc']]
			: [['next.config.cjs', 'next.config.js', 'next.config.ts']]
			: [['.pnpmfile.cjs', 'pnpm-lock.yaml', 'pnpm-workspace.yaml']]
			: [['vercel.json']]
			: [['vite.config.cjs', 'vite.config.cts', 'vite.config.js', 'vite.config.mjs', 'vite.config.mts', 'vite.config.ts', 'vitest.config.cjs', 'vitest.config.cts', 'vitest.config.js', 'vitest.config.mjs', 'vitest.config.mts', 'vitest.config.ts']]
			: [['tmux.conf', 'tmux.conf.local']]
			: [[AUTHORS, 'AUTHORS.txt']]
			: [['index.theme']]
			: [['playwright.config.cjs', 'playwright.config.cts', 'playwright.config.js', 'playwright.config.mjs', 'playwright.config.mts', 'playwright.config.ts']]
			: [['.justfile', justfile]]
			: [['.gitlab-ci.yml']]
			: [[vagrantfile]]
			: [[PKGBUILD]]
			: [['FreeCAD.conf']]
			: [[kdenlive-layoutsrc, kdenliverc]]
			: [[kritadisplayrc, kritarc]]
			: [[fp-info-cache, fp-lib-table, sym-lib-table]]
			: [['PrusaSlicer.ini', 'PrusaSlicerGcodeViewer.ini']]
			: [[bspwmrc, sxhkdrc]]
			: [['hypridle.conf', 'hyprland.conf', 'hyprlandd.conf', 'hyprlock.conf', 'hyprpaper.conf', 'hyprsunset.conf', 'xdph.conf']]
			: [['i3blocks.conf', 'i3status.conf']]
			: [[xmobarrc, 'xmobarrc.hs', 'xmonad.hs']]
			: [['.gtkrc-2.0', gtkrc]]
			: [['lxde-rc.xml']]
			: [['lxqt.conf']]
			: [['weston.ini']]
			: [['.Xauthority', '.xinitrc', '.Xresources', '.xsession', 'xorg.conf', 'xsettingsd.conf']]
			: [['mpv.conf']]
			: [[cantorrc, kalgebrarc, kdeglobals]]
			: [['QtProject.conf']]
			: [['.env']]
			: [[readme, rmd]]
			: [[code_of_conduct, 'code_of_conduct.md']]
			󰒃: [[security, 'security.md']]
			󰓆: [['.codespellrc']]
			󰓙: [[checkhealth]]
			󰕼: [[vlcrc]]
			󰗊: [['i18n.config.js', 'i18n.config.ts']]
			󰚩: [['robots.txt']]
			󰛢: [['.pre-commit-config.yaml']]
			󰜘: [['commitlint.config.js', 'commitlint.config.ts']]
			󰜫: [[webpack]]
			󰡨: [['.dockerignore', 'compose.yaml', 'compose.yml', containerfile, 'docker-compose.yaml', 'docker-compose.yml', dockerfile]]
			󰣇: [['.SRCINFO']]
			󱄆: [['.nuxtrc', 'nuxt.config.cjs', 'nuxt.config.js', 'nuxt.config.mjs', 'nuxt.config.ts']]
			󱏿: [['tailwind.config.js', 'tailwind.config.mjs', 'tailwind.config.ts']]
			# [[sort off]]
		}
		exts: {
			: [['3gp', cast, 'm4v', mkv, mov, 'mp4', ogv, ogx, webm, wmv]]
			: [['7z', bz, 'bz2', 'bz3', gz, rar, tgz, txz, xz, zip, zst]]
			: [[aac, aif, aiff, ape, flac, 'm4a', 'mp3', oga, ogg, opus, pcm, spx, wav, wma, wv, wvc]]
			: [[bat, cfg, conf, ini, yaml, yml, cson, json, 'json5', jsonc, nswag, webmanifest, kdl, toml, xml, xslt]]
			: [[image, img, iso]]
			# [[sort on]]
			: [[query]]
			: [[ebook, epub, mobi]]
			: [[drl]]
			: [[material]]
			: [[styl]]
			: [[sass, scss]]
			: [[pxd, pxi, py, pyc, pyd, pyi, pyo, pyw, pyx], '#ffbc03']
			: [[php]]
			: [[license]]
			: [[avif, bmp, gif, ico, jpeg, jpg, jxl, png, webp]]
			: [[ejs, erb, haml, htm, slim]]
			: [[hbs, mustache]]
			: [[less]]
			: [[rss]]
			: [[coffee]]
			: [[twig]]
			: [[c++, cc, ccm, cp, cpp, cppm, cxx, cxxm, ixx, mm, mpp]]
			: [[c, m]]
			: [[hs, lhs]]
			: [[lua, luac, luau], '#51a0cf']
			: [[jl]]
			: [[jsx]]
			: [[go], '#00add8']
			: [[vim]]
			: [[elm]]
			: [[eex, ex, exs, heex, leex]]
			: [[cr], '#000000']
			: [[epp, pp]]
			: [[el, elc, eln]]
			: [[org]]
			: [[kt, kts]]
			: [[asm, s]]
			: [[bazel, bzl]]
			: [[bicep, bicepparam]]
			: [[cfc, cfm]]
			: [[csv]]
			: [[cu, cuh]]
			: [[sol]]
			: [[gd, godot, tres, tscn]]
			: [[gradle]]
			: [[hx]]
			: [[hex]]
			: [[liquid]]
			: [[lck, lock]]
			: [[nim]]
			: [[ml, mli]]
			: [[prisma]]
			: [[res, resi]]
			: [[rs, rlib], '#dea584']
			: [[x, xm]]
			: [[svelte]]
			: [[tf]]
			: [[tex]]
			: [[cts, 'd.ts', mts, ts], '#3178C6']
			: [[vue]]
			: [[wasm]]
			: [[zig]]
			: [[vsh]]
			: [[fnl]]
			: [[astro]]
			: [[ada, adb, ads, gpr]]
			: [[css]]
			: [[git]]
			: [[db, dump, sql, sqlite, 'sqlite3']]
			: [[dropbox]]
			: [[sln, slnx, suo, vsix]]
			: [[android, apk]]
			: [[conda]]
			: [[diff, patch]]
			: [[apl, bqn]]
			: [[html]]
			: [[sbt, sc, scala]]
			: [[jar, java]]
			: [[xul]]
			: [[swift, xcplayground]]
			: [[clj, cljc]]
			: [[pl, pm, t]]
			: [[cljd, cljs, edn]]
			: [[tsconfig, typoscript]]
			: [[cjs, js, mjs], '#f7df1e']
			: [[xpi]]
			: [['config.ru', gemspec, rake, rb]]
			: [[cmake]]
			: [[awk, csh, fish, ksh, sh, zsh, bash, nu]]
			: [[dart]]
			: [[pro]]
			: [['f#', fs, fsi, fsscript, fsx]]
			: [[sublime]]
			: [[d]]
			: [[erl, hrl]]
			: [[ai]]
			: [[feature]]
			: [[psb, psd]]
			: [[tsx]]
			: [[ipynb]]
			: [[vi]]
			: [[norg]]
			: [[frag, geom, glsl, vert]]
			: [['stories.js', 'stories.jsx', 'stories.mjs', 'stories.svelte', 'stories.ts', 'stories.tsx', 'stories.vue']]
			: [[vala]]
			: [[templ, tmpl]]
			: [[app, bin, elf, exe, o, out]]
			: [[pdf]]
			: [[a, dll, lib, so]]
			: [[tmux]]
			: [[azcli]]
			: [[rasi]]
			: [[mo]]
			: [[gleam]]
			: [[crdownload, download, fdmdownload, part, torrent]]
			: [[eot, flc, flf, lff, otf, ttf, woff, 'woff2']]
			: [[mojo, 🔥]]
			: [[ical, icalendar, ics, ifb]]
			: [[magnet]]
			: [[import]]
			: [[hurl]]
			: [[h, hh, hpp, hxx]]
			: [[desktop]]
			: [[info, nfo]]
			: [[applescript]]
			: [[ko]]
			: [[po, pot, qm, strings, xcstrings]]
			: [[glb]]
			: [[http]]
			: [[gql, graphql]]
			: [[kdb, kdbx]]
			: [[ui]]
			: [['blade.php']]
			: [[ebuild]]
			: [[nix]]
			: [[fcbak, fcmacro, fcmat, fcparam, fcscript, fcstd, 'fcstd1', fctb, fctl]]
			: [[xcf]]
			: [[kdenlive, kdenlivetitle]]
			: [[kpp, kra, krz]]
			: [[ino]]
			: [[kicad_dru, kicad_mod, kicad_pcb, kicad_prl, kicad_pro, kicad_sch, kicad_sym, kicad_wks]]
			: [[scad]]
			: [[jwmrc]]
			: [[dconf]]
			: [[gresource]]
			: [[msf]]
			: [[qml, qrc, qss]]
			: [[fods, ods]]
			: [[fodg, odg]]
			: [[fodp, odp]]
			: [[odf]]
			: [[fodt, odt]]
			: [[typ]]
			: [[env]]
			: [[pck]]
			: [[terminal]]
			: [[md, mdx, markdown]]
			: [['spec.js', 'spec.jsx', 'spec.ts', 'spec.tsx', 'test.js', 'test.jsx', 'test.ts', 'test.tsx']]
			: [[cache]]
			󰁯: [[bak]]
			󰂫: [[blend]]
			󰆚: [[cow]]
			󰆧: [['3mf', fbx, obj, ply, stl, wrl, wrz]]
			󰈙: [[txt]]
			󰈛: [[xls, xlsx]]
			󰈧: [[ppt, pptx]]
			󰈬: [[doc, docx]]
			󰌛: [[cs]]
			󰌪: [[mint]]
			󰌱: [[log]]
			󰍛: [[sv, svh, v, vh, vhd, vhdl]]
			󰐫: [[gcode]]
			󰕥: [['md5', 'sha1', 'sha224', 'sha256', 'sha384', 'sha512']]
			󰗆: [[rproj]]
			󰘧: [[scm, sig, signature, sml]]
			󰙳: [[xaml]]
			󰛓: [[tbc, tcl]]
			󰜡: [[svg, svgz]]
			󰜫: [[webpack]]
			󰟔: [[R, r]]
			󰟢: [[odin]]
			󰡘: [[huff]]
			󰡨: [[Dockerfile, dockerignore]]
			󰦝: [[asc]]
			󰨊: [['ps1', 'psd1', 'psm1']]
			󰨖: [[ass, lrc, srt, ssa, sub]]
			󰪮: [[csproj]]
			󰯄: [[kbx]]
			󰲹: [[cue, 'm3u', 'm3u8', pls]]
			󰷖: [[pub]]
			󰺾: [[blp]]
			󰻫: [[brep, dwg, dxf, 'f3d', ifc, ige, iges, igs, skp, sldasm, sldprt, slvs, ste, step, stp]]
			󱁉: [[dot, gv]]
			󱈚: [['f90']]
			󱉟: [[bib]]
			󱦗: [[cshtml]]
			󱦘: [[razor]]
			# [[sort off]]
		}
		conds: [
			{ if: orphan         , text:  }
			{ if: link           , text:  }
			{ if: block          , text:  }
			{ if: char           , text:  }
			{ if: fifo           , text:  }
			{ if: sock           , text:  }
			{ if: sticky         , text:  }
			{ if: dummy          , text:  }
			{ if: 'dir & hovered', text:  }
			{ if: dir            , text:  }
			{ if: exec           , text:  }
			{ if: '!dir'         , text:  }
		]
	}
}

def parse_icons [] {
	items { |key, value|
		$value.0
		| each { |it|
			let color = $value | get -o 1
			if ($color | is-not-empty) {
				{ text: $key, name: $it, fg: $color }
			} else {
				{ text: $key, name: $it }
			}
		}
	}
	| flatten
}

$config
| update cells -c [icon] { update cells -c [dirs files exts] { parse_icons } }
| to toml
| save -f ($self | path dirname | path join theme.toml)
