// begin Cargo.toml
// [dependencies]
// # clap = { version = "4.5.23", features = ["wrap_help", "derive"] }
// end Cargo.toml
// /home/axlefublr/prog/dotfiles/scripts/velvidek.rs
#![allow(unused_imports)]
#![allow(unused_variables)]

use std::env::args;
use std::env::{self};
use std::error::Error;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::Read;
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;

fn main() -> Result<(), Box<dyn Error>> {
    let maybe_layer_number: Option<String> = args().nth(1);
    let Some(layer_number) = maybe_layer_number else {
        return Ok(());
    };
    let actual_number = match &layer_number[..] {
        "f" => 1,
        "d" => 2,
        "s" => 3,
        "r" => 4,
        "e" => 5,
        "w" => 6,
        "v" => 7,
        "c" => 8,
        "x" => 9,
        "a" => 10,
        _ => unimplemented!("numbers above 10"),
    };
    println!("%{actual_number}");
    Ok(())
}
