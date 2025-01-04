// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/prog/dotfiles/scripts/shift.rs
#![allow(unused_imports)]
#![allow(unused_variables)]
#![allow(dead_code)]

use std::env;
use std::env::args;
use std::error::Error;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::stdin;
use std::io::Read;
use std::io::Seek;
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<(), Box<dyn Error>> {
    let mut args = args().skip(1);
    let path: PathBuf = args
        .next()
        .and_then(|maybe_path| maybe_path.parse().ok())
        .expect("argument is not a filepath");
    let count: usize = args
        .next()
        .and_then(|maybe_count| maybe_count.parse().ok())
        .unwrap_or(1);
    let mut file = OpenOptions::new()
        .read(true)
        .write(true)
        .open(path)
        .unwrap();
    let mut contents = String::new();
    file.read_to_string(&mut contents)
        .expect("read file");
    let mut lines = contents.lines();
    for line in lines.by_ref().take(count) {
        println!("{}", line);
    }
    file.set_len(0).expect("set_len");
    file.rewind().expect("rewind");
    let lines = lines.collect::<Vec<&str>>();
    if lines.is_empty() {
        return Ok(());
    }
    writeln!(file, "{}", lines.join("\n")).expect("write lines back");
    Ok(())
}
