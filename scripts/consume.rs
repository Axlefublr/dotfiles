// begin Cargo.toml
// [dependencies]
// clap = { version = "4.5.38", features = ["derive"] }
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/consume.rs
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
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

use clap::Parser;

#[derive(Parser)]
struct Orgs {
    files: Vec<PathBuf>,
}

fn main() -> Result<(), Box<dyn Error>> {
    let Orgs { files } = Orgs::parse();
    for file in files {
        print!("{}", fs::read_to_string(&file).unwrap());
        fs::remove_file(file).unwrap();
    }
    Ok(())
}
