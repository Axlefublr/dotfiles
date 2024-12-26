#!/usr/bin/env run-cargo-script
//! ```cargo
//! [dependencies]
//! ```
// /home/axlefublr/prog/dotfiles/scripts/scriptister/import-rust-script.rs
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
    let maybe_filepath: PathBuf = env::args()
        .nth(1)
        .expect("no arguments provided")
        .parse()
        .expect("provided argument is not a file path");
    let file = fs::read_to_string(maybe_filepath).unwrap();
    let lines: Vec<&str> = file.lines().skip(2).collect();

    let cargo_file = lines
        .iter()
        .take_while(|&&line| line != "//! ```")
        .map(|line| line.chars().skip(4).collect::<String>())
        .collect::<Vec<_>>()
        .join("\n");

    let main_file = lines
        .iter()
        .skip_while(|&&line| line != "//! ```")
        .skip(1)
        .map(|&line| line.to_owned())
        .collect::<Vec<_>>()
        .join("\n");

    let mut file = OpenOptions::new()
        .create(true)
        .truncate(true)
        .write(true)
        .open("/home/axlefublr/prog/wks/src/main.rs")
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
        .open("/home/axlefublr/prog/wks/Cargo.toml")
        .unwrap();
    writeln!(file, "{CARGO_BULLSHIT}{}", cargo_file).unwrap();

    Ok(())
}
