#!/usr/bin/env -S nu -n --no-std-lib

const self = path self
const red = '#ea6962'
const orange = '#e49641'
const yellow = '#d3ad5c'
const green = '#a9b665'
const mint = '#212121'
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
			: [[".config"]]
			: [[".git"]]
			: [[".github"]]
			: [[".npm"]]
		}
		files: {
			: [[".babelrc"]]
			: [[".bash_profile", ".bashrc", ".clang-format", ".clang-tidy", ".ds_store", ".gitconfig", ".luacheckrc", ".luaurc", ".pylintrc", ".zprofile", ".zshenv", ".zshrc", config, "Directory.Build.props", "Directory.Build.targets", "Directory.Packages.props"]]
			󰓆: [[".codespellrc"]]
			: [[".condarc"]]
			󰡨: [[".dockerignore", "compose.yaml", "compose.yml", containerfile, "docker-compose.yaml", "docker-compose.yml", dockerfile]]
			: [[".editorconfig"]]
			: [[".env"]]
			: [[".eslintignore", ".eslintrc", "eslint.config.cjs", "eslint.config.js", "eslint.config.mjs", "eslint.config.ts"]]
			: [[".git-blame-ignore-revs", ".gitattributes", ".gitignore", ".gitmodules", commit_editmsg]]
			: [[".gitlab-ci.yml"]]
			: [[".gtkrc-2.0", gtkrc]]
			: [[".gvimrc", ".vimrc", _gvimrc, _vimrc]]
			: [[".justfile", justfile]]
			󰊢: [[".mailmap"]]
			: [[".nanorc"]]
			: [[".npmignore", ".npmrc", "package-lock.json", "package.json"]]
			󱄆: [[".nuxtrc", "nuxt.config.cjs", "nuxt.config.js", "nuxt.config.mjs", "nuxt.config.ts"]]
			: [[".nvmrc", node_modules]]
			: [[".pnpmfile.cjs", "pnpm-lock.yaml", "pnpm-workspace.yaml"]]
			󰛢: [[".pre-commit-config.yaml"]]
			: [[".prettierignore", ".prettierrc", ".prettierrc.cjs", ".prettierrc.js", ".prettierrc.json", ".prettierrc.json5", ".prettierrc.mjs", ".prettierrc.toml", ".prettierrc.yaml", ".prettierrc.yml", "prettier.config.cjs", "prettier.config.js", "prettier.config.mjs", "prettier.config.ts"]]
			: [[".settings.json"]]
			󰣇: [[".SRCINFO"]]
			: [[".Xauthority", ".xinitrc", ".Xresources", ".xsession", "xorg.conf", "xsettingsd.conf"]]
			: [[AUTHORS, "AUTHORS.txt"]]
			: [[brewfile, Gemfile, rakefile]]
			: [[bspwmrc, sxhkdrc]]
			: [[build, workspace]]
			: [["build.gradle", "gradle-wrapper.properties", "gradle.properties", gradlew, "settings.gradle"]]
			: [["build.zig.zon"]]
			: [["bun.lock", "bun.lockb"]]
			: [[cantorrc, kalgebrarc, kdeglobals]]
			󰓙: [[checkhealth]]
			: [["cmakelists.txt"]]
			: [[code_of_conduct, "code_of_conduct.md"]]
			󰜘: [["commitlint.config.js", "commitlint.config.ts"]]
			: [[copying, "copying.lesser", license, "license.md", unlicense]]
			: [["ext_typoscript_setup.txt"]]
			: [["favicon.ico"]]
			: [[fp-info-cache, fp-lib-table, sym-lib-table]]
			: [["FreeCAD.conf"]]
			: [[gnumakefile, makefile]]
			: [["go.mod", "go.sum", "go.work"]]
			: [[groovy]]
			: [["gruntfile.babel.js", "gruntfile.coffee", "gruntfile.js", "gruntfile.ts"]]
			: [["gulpfile.babel.js", "gulpfile.coffee", "gulpfile.js", "gulpfile.ts"]]
			: [["hypridle.conf", "hyprland.conf", "hyprlandd.conf", "hyprlock.conf", "hyprpaper.conf", "hyprsunset.conf", "xdph.conf"]]
			󰗊: [["i18n.config.js", "i18n.config.ts"]]
			: [["i3blocks.conf", "i3status.conf"]]
			: [["index.theme"]]
			: [["ionic.config.json"]]
			: [[Jenkinsfile]]
			: [[kdenlive-layoutsrc, kdenliverc]]
			: [[kritadisplayrc, kritarc]]
			: [["lxde-rc.xml"]]
			: [["lxqt.conf"]]
			: [["mix.lock"]]
			: [["mpv.conf"]]
			: [["next.config.cjs", "next.config.js", "next.config.ts"]]
			: [[PKGBUILD]]
			: [["platformio.ini"]]
			: [["playwright.config.cjs", "playwright.config.cts", "playwright.config.js", "playwright.config.mjs", "playwright.config.mts", "playwright.config.ts"]]
			: [["pom.xml"]]
			: [["prisma.config.mts", "prisma.config.ts"]]
			: [[procfile]]
			: [["PrusaSlicer.ini", "PrusaSlicerGcodeViewer.ini"]]
			: [["py.typed"]]
			: [["QtProject.conf"]]
			󰂺: [[readme, "readme.md"]]
			: [[rmd]]
			󰚩: [["robots.txt"]]
			󰒃: [[security, "security.md"]]
			: [["svelte.config.js"]]
			󱏿: [["tailwind.config.js", "tailwind.config.mjs", "tailwind.config.ts"]]
			: [["tmux.conf", "tmux.conf.local"]]
			: [["tsconfig.json"]]
			: [[vagrantfile]]
			: [["vercel.json"]]
			: [["vite.config.cjs", "vite.config.cts", "vite.config.js", "vite.config.mjs", "vite.config.mts", "vite.config.ts", "vitest.config.cjs", "vitest.config.cts", "vitest.config.js", "vitest.config.mjs", "vitest.config.mts", "vitest.config.ts"]]
			󰕼: [[vlcrc]]
			󰜫: [[webpack]]
			: [["weston.ini"]]
			: [["wrangler.jsonc", "wrangler.toml"]]
			: [[xmobarrc, "xmobarrc.hs", "xmonad.hs"]]
		}
		exts: {
			: [["3gp", cast, "m4v", mkv, mov, "mp4", ogv, ogx, webm, wmv]]
			󰆧: [["3mf", fbx, obj, ply, stl, wrl, wrz]]
			: [["7z", bz, "bz2", "bz3", gz, rar, tgz, txz, xz, zip, zst]]
			: [[a, dll, lib, so]]
			: [[aac, aif, aiff, ape, flac, "m4a", "mp3", oga, ogg, opus, pcm, spx, wav, wma, wv, wvc]]
			: [[ada, adb, ads, gpr]]
			: [[ai]]
			: [[android, apk]]
			: [[apl, bqn]]
			: [[app, bin, elf, exe, o, out]]
			: [[applescript]]
			󰦝: [[asc]]
			: [[asm, s]]
			󰨖: [[ass, lrc, srt, ssa, sub]]
			: [[astro]]
			: [[avif, bmp, gif, ico, jpeg, jpg, jxl, png, webp]]
			: [[awk, csh, fish, ksh, sh, zsh]]
			: [[azcli]]
			󰁯: [[bak]]
			: [[bash]]
			: [[bat, cfg, conf, ini, yaml, yml]]
			: [[bazel, bzl]]
			󱉟: [[bib]]
			: [[bicep, bicepparam]]
			: [["blade.php"]]
			󰂫: [[blend]]
			󰺾: [[blp]]
			󰻫: [[brep, dwg, dxf, "f3d", ifc, ige, iges, igs, skp, sldasm, sldprt, slvs, ste, step, stp]]
			: [[c, m]]
			: [[c++, cc, ccm, cp, cpp, cppm, cxx, cxxm, ixx, mm, mpp]]
			: [[cache]]
			: [[cbl, cob, cobol, cpy]]
			: [[cfc, cfm]]
			: [[cjs, js, mjs]]
			: [[clj, cljc]]
			: [[cljd, cljs, edn]]
			: [[cmake]]
			: [[coffee]]
			: [[conda]]
			: [["config.ru", gemspec, rake, rb]]
			󰆚: [[cow]]
			: [[cr]]
			: [[crdownload, download, fdmdownload, part, torrent]]
			󰌛: [[cs]]
			󱦗: [[cshtml]]
			: [[cson, json, "json5", jsonc, nswag, webmanifest]]
			󰪮: [[csproj]]
			: [[css]]
			: [[csv]]
			: [[cts, "d.ts", mts, ts]]
			: [[cu, cuh]]
			󰲹: [[cue, "m3u", "m3u8", pls]]
			: [[d]]
			: [[dart]]
			: [[db, dump, sql, sqlite, "sqlite3"]]
			: [[dconf]]
			: [[desktop]]
			: [[diff, patch]]
			󰈬: [[doc, docx]]
			󰡨: [[Dockerfile, dockerignore]]
			󱁉: [[dot, gv]]
			: [[drl]]
			: [[dropbox]]
			: [[ebook, epub, mobi]]
			: [[ebuild]]
			: [[eex, ex, exs, heex, leex]]
			: [[ejs, erb, haml, htm, slim]]
			: [[el, elc, eln]]
			: [[elm]]
			: [[env]]
			: [[eot, flc, flf, lff, otf, ttf, woff, "woff2"]]
			: [[epp, pp]]
			: [[erl, hrl]]
			: [["f#", fs, fsi, fsscript, fsx]]
			󱈚: [["f90"]]
			: [[fcbak, fcmacro, fcmat, fcparam, fcscript, fcstd, "fcstd1", fctb, fctl]]
			: [[feature]]
			: [[fnl]]
			: [[fodg, odg]]
			: [[fodp, odp]]
			: [[fods, ods]]
			: [[fodt, odt]]
			: [[frag, geom, glsl, vert]]
			󰐫: [[gcode]]
			: [[gd, godot, tres, tscn]]
			: [[git]]
			: [[glb]]
			: [[gleam]]
			: [[gnumakefile, makefile, mk]]
			: [[go]]
			: [[gql, graphql]]
			: [[gradle]]
			: [[gresource]]
			: [[h, hh, hpp, hxx]]
			: [[hbs, mustache]]
			: [[hex]]
			: [[hs, lhs]]
			: [[html]]
			: [[http]]
			󰡘: [[huff]]
			: [[hurl]]
			: [[hx]]
			: [[ical, icalendar, ics, ifb]]
			: [[image, img, iso]]
			: [[import]]
			: [[info, nfo]]
			: [[ino]]
			: [[ipynb]]
			: [[jar, java]]
			: [[jl]]
			: [[jsx]]
			: [[jwmrc]]
			󰯄: [[kbx]]
			: [[kdb, kdbx]]
			: [[kdenlive, kdenlivetitle]]
			: [[kicad_dru, kicad_mod, kicad_pcb, kicad_prl, kicad_pro, kicad_sch, kicad_sym, kicad_wks]]
			: [[ko]]
			: [[kpp, kra, krz]]
			: [[kt, kts]]
			: [[lck, lock]]
			: [[less]]
			: [[license]]
			: [[liquid]]
			󰌱: [[log]]
			: [[lua, luac, luau]]
			: [[magnet]]
			: [[markdown, rmd]]
			: [[material]]
			: [[md, mdx]]
			󰕥: [["md5", "sha1", "sha224", "sha256", "sha384", "sha512"]]
			󰌪: [[mint]]
			: [[ml, mli]]
			: [[mo]]
			: [[mojo, 🔥]]
			: [[msf]]
			: [[nim]]
			: [[nix]]
			: [[norg]]
			: [[nu]]
			: [[odf]]
			󰟢: [[odin]]
			: [[org]]
			: [[pck]]
			: [[pdf]]
			: [[php]]
			: [[pl, pm, t]]
			: [[po, pot, qm, strings, xcstrings]]
			󰈧: [[ppt, pptx]]
			: [[prisma]]
			: [[pro]]
			󰨊: [["ps1", "psd1", "psm1"]]
			: [[psb, psd]]
			󰷖: [[pub]]
			: [[pxd, pxi, py, pyc, pyd, pyi, pyo, pyw, pyx]]
			: [[qml, qrc, qss]]
			: [[query]]
			󰟔: [[R, r]]
			: [[rasi]]
			󱦘: [[razor]]
			: [[res, resi]]
			: [[rlib]]
			󰗆: [[rproj]]
			: [[rs]]
			: [[rss]]
			: [[sass, scss]]
			: [[sbt, sc, scala]]
			: [[scad]]
			󰘧: [[scm, sig, signature, sml]]
			: [[sln, slnx, suo, vsix]]
			: [[sol]]
			: [["spec.js", "spec.jsx", "spec.ts", "spec.tsx", "test.js", "test.jsx", "test.ts", "test.tsx"]]
			: [["stories.js", "stories.jsx", "stories.mjs", "stories.svelte", "stories.ts", "stories.tsx", "stories.vue"]]
			: [[styl]]
			: [[sublime]]
			󰍛: [[sv, svh, v, vh, vhd, vhdl]]
			: [[svelte]]
			󰜡: [[svg, svgz]]
			: [[swift, xcplayground]]
			󰛓: [[tbc, tcl]]
			: [[templ, tmpl]]
			: [[terminal]]
			: [[tex]]
			: [[tf]]
			: [[tfvars]]
			: [[tmux]]
			: [[toml]]
			: [[tsconfig, typoscript]]
			: [[tsx]]
			: [[twig]]
			󰈙: [[txt]]
			: [[typ]]
			: [[ui]]
			: [[vala]]
			: [[vi]]
			: [[vim]]
			: [[vsh]]
			: [[vue]]
			: [[wasm]]
			󰜫: [[webpack]]
			: [[x, xm]]
			󰙳: [[xaml]]
			: [[xcf]]
			󰈛: [[xls, xlsx]]
			󰗀: [[xml, xslt]]
			: [[xpi]]
			: [[xul]]
			: [[zig]]
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
			{ if: "dir & hovered", text:  }
			{ if: dir            , text:  }
			{ if: exec           , text:  }
			{ if: "!dir"         , text:  }
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
