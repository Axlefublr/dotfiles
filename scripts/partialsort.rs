// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/partialsort.rs
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
use std::io::BufRead;
use std::io::Read;
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<(), Box<dyn Error>> {
    let stdin = io::stdin();
    let reader = io::BufReader::new(stdin);
    let mut sorting = false;
    let mut collected = Vec::new();
    for line in reader.lines() {
        let line = line.unwrap();
        if line.contains("[[sort on]]") {
            println!("{}", line);
            sorting = true;
        } else if line.contains("[[sort off]]") {
            sorting = false;
            collected.sort();
            println!("{}", collected.join("\n"));
            collected.truncate(0);
            println!("{}", line);
        } else if sorting {
            collected.push(line);
        } else {
            println!("{}", line);
        }
    }
    if !collected.is_empty() {
        collected.sort();
        println!("{}", collected.join("\n"));
    }
    Ok(())
}
