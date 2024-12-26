#!/usr/bin/env run-cargo-script
//! ```cargo
//! [dependencies]
//! ```
// /home/axlefublr/prog/dotfiles/scripts/scriptister/export-rust-script.rs
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
use std::os::unix::fs::PermissionsExt;
use std::path::Component;
use std::path::Path;
use std::path::PathBuf;

const SCRIPT_FILLER: &str = "\
#!/usr/bin/env run-cargo-script
//! ```cargo
";

fn main() -> Result<(), Box<dyn Error>> {
    let maybe_filepath: Option<PathBuf> = env::args()
        .nth(1)
        .and_then(|maybe_filepath| maybe_filepath.parse().ok());

    let main_file = fs::read_to_string("/home/axlefublr/prog/wks/src/main.rs").unwrap();
    let main_file = main_file.lines();

    let extract_filepath_from_lines = || -> PathBuf {
        main_file
            .clone()
            .peekable()
            .peek()
            .expect("first line missing")
            .chars()
            .skip(3)
            .collect::<String>()
            .parse::<PathBuf>()
            .expect("first line should be a path")
    };

    let cargo_file = fs::read_to_string("/home/axlefublr/prog/wks/Cargo.toml").unwrap();
    let cargo_file = cargo_file
        .lines()
        .skip_while(|&line| line != "[dependencies]")
        .map(|line| format!("//! {line}"))
        .collect::<Vec<String>>()
        .join("\n");

    let target_file_path = maybe_filepath.unwrap_or_else(extract_filepath_from_lines);

    let rest_of_file: String = main_file
        .collect::<Vec<_>>()
        .join("\n");

    let mut target_file = OpenOptions::new()
        .create(true)
        .truncate(true)
        .write(true)
        .open(target_file_path.as_path())
        .unwrap();

    writeln!(
        target_file,
        "{SCRIPT_FILLER}{cargo_file}\n//! ```\n{rest_of_file}"
    )
    .unwrap();

    let mut permissions = target_file
        .metadata()
        .unwrap()
        .permissions();
    permissions.set_mode(0o755); // rwxr-xr-x
    fs::set_permissions(target_file_path, permissions).unwrap();

    Ok(())
}
