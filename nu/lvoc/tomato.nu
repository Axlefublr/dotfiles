#!/usr/bin/env -S nu -n --no-std-lib

mut timestamp = (date now)

loop {
	consume.rs /tmp/mine/tomato-action
	| each { |$it|
	}
}
