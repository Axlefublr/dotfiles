export def 'date now date' [] {
	date now | format date '%y.%m.%d'
}

export def 'path shrink' [] {
	let IN = $in
	$IN | try {
		path relative-to ~ | '~/' + $in
	} catch {
		$IN
	}
}

export def 'tit' [title?: string] {
	printf '\e]2;%s\a' $title
}
