#!/usr/bin/env scriptisto

// scriptisto-begin
// script_src: src/main.rs
// build_cmd: cargo build --release && strip ./target/release/wks
// target_bin: ./target/release/wks
// files:
//  - path: Cargo.toml
//    content: |
//     [package]
//     name = "wks"
//     version = "0.0.1"
//     edition = "2021"
//     
//     [dependencies]
//     # clap = { version = "4.5.23", features = ["wrap_help", "derive"] }
// scriptisto-end

// ~/prog/dotfiles/scripts/export-rust-script.rs
#![allow(unused_imports)]
#![allow(unused_variables)]

use std::convert::AsRef;
use std::env;
use std::error::Error;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::Read;
use std::io::Write;
use std::path::Component;
use std::path::Path;
use std::path::PathBuf;

const SCRIPTISTO_FILLER: &str = "\
#!/usr/bin/env scriptisto

// scripti";

/// scriptisto freaks out if there are two starter scriptisto tags, so that's why we need to split
const SCRIPTISTO_FILLER_2: &str = "\
sto-begin
// script_src: src/main.rs
// build_cmd: cargo build --release && strip ./target/release/wks
// target_bin: ./target/release/wks
// files:
//  - path: Cargo.toml
//    content: |
";

fn main() -> Result<(), Box<dyn Error>> {
    let maybe_filepath: Option<PathBuf> = env::args()
        .nth(1)
        .and_then(|maybe_filepath| maybe_filepath.parse().ok());

    let main_file = fs::read_to_string("/home/axlefublr/prog/wks/src/main.rs").unwrap();
    let cargo_file = fs::read_to_string("/home/axlefublr/prog/wks/Cargo.toml").unwrap();
    let mut main_file = main_file.lines();
    let cargo_file = cargo_file
        .lines()
        .map(|line| format!("//     {line}"))
        .collect::<Vec<String>>()
        .join("\n");

    let extract_filepath_from_lines = || -> PathBuf {
        main_file
            .next()
            .expect("first line missing")
            .chars()
            .skip(3)
            .collect::<String>()
            .parse::<PathBuf>()
            .expect("first line should be a path")
    };

    let target_file = maybe_filepath.unwrap_or_else(extract_filepath_from_lines);

    let mut comps = target_file.components();
    let maybe_home = comps.next().unwrap();
    let mut target_file = {
        if maybe_home.as_os_str() == "~" {
            PathBuf::from("/home/axlefublr")
        } else {
            PathBuf::from(<Component<'_> as AsRef<Path>>::as_ref(&maybe_home))
        }
    };
    target_file.push(comps);

    let rest_of_file: String = main_file.collect::<Vec<_>>().join("\n");

    let mut target_file = OpenOptions::new()
        .create(true)
        .truncate(true)
        .write(true)
        .open(target_file)
        .unwrap();

    write!(
        target_file,
        "{SCRIPTISTO_FILLER}{SCRIPTISTO_FILLER_2}{cargo_file}\n// scriptisto-end\n\n{rest_of_file}"
    )
    .unwrap();

    Ok(())
}
