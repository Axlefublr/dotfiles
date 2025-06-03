// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/scriptister/export-rust-script.rs
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
use std::os::unix::process::CommandExt;
use std::path::Component;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<(), Box<dyn Error>> {
    let maybe_filepath: Option<PathBuf> = env::args()
        .nth(1)
        .and_then(|maybe_filepath| maybe_filepath.parse().ok());

    let main_file = fs::read_to_string("/home/axlefublr/fes/wks/src/main.rs").unwrap();
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

    let cargo_file = fs::read_to_string("/home/axlefublr/fes/wks/Cargo.toml").unwrap();
    let cargo_file = cargo_file
        .lines()
        .skip_while(|&line| line != "[dependencies]")
        .map(|line| format!("// {line}"))
        .collect::<Vec<String>>()
        .join("\n");

    let target_file_path = maybe_filepath.unwrap_or_else(extract_filepath_from_lines);

    let rest_of_file: String = main_file.collect::<Vec<_>>().join("\n");

    let mut target_file = OpenOptions::new()
        .create(true)
        .truncate(true)
        .write(true)
        .open(target_file_path.as_path())
        .unwrap();

    writeln!(
        target_file,
        "// begin Cargo.toml\n{cargo_file}\n// end Cargo.toml\n{rest_of_file}"
    )
    .unwrap();

    let target_file_path_name = target_file_path.file_name().unwrap();

    Command::new("compile-rust-script.fish")
        .arg(target_file_path_name)
        .exec();
    Ok(())
}
