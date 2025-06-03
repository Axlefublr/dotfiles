// begin Cargo.toml
// [dependencies]
// clap = { version = '4.5', features = ['derive', 'wrap_help'] }
// end Cargo.toml
// /home/axlefublr/fes/dot/scripts/indeed.rs
#![allow(unused_imports)]
#![allow(unused_variables)]
#![allow(dead_code)]

use std::env;
use std::error::Error;
use std::fmt;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io;
use std::io::Read;
use std::io::Seek;
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

use clap::Parser;

#[derive(Parser)]
struct Argies {
    path: PathBuf,
    #[arg(short, long)]
    unique: bool,
    lines: Vec<String>,
}

fn main() -> Result<(), Box<dyn Error>> {
    let args = Argies::parse();
    if !args.unique {
        let mut file = OpenOptions::new()
            .read(true)
            .append(true)
            .create(true)
            .open(args.path)
            .unwrap();
        fn should_fix_trailing_newline(file: &mut File) -> Option<bool> {
            let mut buf = [0u8];
            file.seek(io::SeekFrom::End(-1)).ok()?; // happens if the file is empty; we shouldn't fix the newline
            if file.read_exact(&mut buf).is_err() {
                // happens if the file is not empty, but we can't read a single byte...
                return Some(true); // in which case it's safer to assume that we should add an extra newline: removing a dangling newline is less annoying than untangling two joined lines
            };
            Some(buf != [b'\n']) // if last char *is* a newline, we shouldn't fix
        }
        let should_fix_trailing_newline =
            should_fix_trailing_newline(&mut file).unwrap_or_default();
        if should_fix_trailing_newline {
            writeln!(file).unwrap();
        }
        writeln!(file, "{}", args.lines.join("\n")).unwrap();
    } else {
        let mut file = OpenOptions::new()
            .read(true)
            .write(true)
            .truncate(false)
            .create(true)
            .open(args.path)
            .unwrap();
        let mut buf = String::new();
        file.read_to_string(&mut buf).unwrap();
        let mut lines: Vec<String> = buf
            .lines()
            .filter(|&line| !args.lines.iter().any(|passed_line| passed_line == line))
            .map(ToOwned::to_owned)
            .collect();
        lines.extend_from_slice(&args.lines);
        file.set_len(0).unwrap();
        file.rewind().unwrap();
        writeln!(file, "{}", lines.join("\n")).unwrap();
    }
    Ok(())
}
