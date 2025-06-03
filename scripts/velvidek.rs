// begin Cargo.toml
// [dependencies]
// # clap = { version = "4.5.23", features = ["wrap_help", "derive"] }
// end Cargo.toml
// /home/axlefublr/fes/dot/scripts/velvidek.rs
#![allow(unused_imports)]
#![allow(unused_variables)]

use std::borrow::Cow;
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
    args()
        .skip(1)
        .map(|arg| {
            arg.chars()
                .map(|chr| match chr {
                    'f' => '1',
                    'd' => '2',
                    's' => '3',
                    'r' => '4',
                    'e' => '5',
                    'w' => '6',
                    'v' => '7',
                    'c' => '8',
                    'x' => '9',
                    'a' => '0',
                    other => other,
                })
                .collect::<Cow<str>>()
        })
        .for_each(|transformed_number| println!("{transformed_number}"));
    Ok(())
}
