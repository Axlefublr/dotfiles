// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/fes/dot/scripts/scriptister/import-rust-script.rs
#![allow(unused_imports)]
#![allow(unused_variables)]

use std::env;
use std::error::Error;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::Read;
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;

fn main() -> Result<(), Box<dyn Error>> {
    let script_path: PathBuf = env::args()
        .nth(1)
        .expect("no arguments provided")
        .parse()
        .expect("provided argument is not a file path");
    let file = fs::read_to_string(&script_path).unwrap();
    let lines: Vec<&str> = file.lines().skip(1).collect();

    let cargo_file = lines
        .iter()
        .take_while(|&&line| line != "// end Cargo.toml")
        .map(|line| line.chars().skip(3).collect::<String>())
        .collect::<Vec<_>>()
        .join("\n");

    let main_file = lines
        .iter()
        .skip_while(|&&line| line != "// end Cargo.toml")
        .skip(1)
        .map(|&line| line.to_owned())
        .collect::<Vec<_>>()
        .join("\n");

    let script_name = script_path.file_name().expect("no script name");

    let cache_dir = {
        let mut the = PathBuf::from("/home/axlefublr/.cache/wks/");
        the.push(script_name);
        the
    };

    let main_parent = {
        let mut the = cache_dir.clone();
        the.push("src");
        the
    };

    let target_dir = {
        let mut the = cache_dir.clone();
        the.push("target");
        the
    };

    if !fs::exists(&main_parent).expect("main_parent existence check") {
        fs::create_dir_all(&main_parent).expect("couldn't create directories");
    }

    if !fs::exists(&target_dir).expect("target_dir existence check") {
        fs::create_dir(&target_dir).expect("couldn't create directories");
    }

    let main_path = {
        let mut the = main_parent;
        the.push("main.rs");
        the
    };

    let cargo_path = {
        let mut the = cache_dir;
        the.push("Cargo.toml");
        the
    };

    let mut file = OpenOptions::new()
        .create(true)
        .truncate(true)
        .write(true)
        .open(main_path)
        .unwrap();
    writeln!(file, "{}", main_file).unwrap();

    const CARGO_BULLSHIT: &str = r#"[package]
name = "wks"
version = "0.0.1"
edition = "2021"

"#;

    let mut file = OpenOptions::new()
        .create(true)
        .truncate(true)
        .write(true)
        .open(cargo_path)
        .unwrap();
    writeln!(file, "{CARGO_BULLSHIT}{}", cargo_file).unwrap();

    Ok(())
}
