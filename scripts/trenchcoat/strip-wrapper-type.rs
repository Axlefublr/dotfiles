// begin Cargo.toml
// [dependencies]
// # clap = { version = "4.5.23", features = ["wrap_help", "derive"] }
// end Cargo.toml
// /home/axlefublr/prog/dotfiles/scripts/trenchcoat/strip-wrapper-type.rs
#![allow(unused_imports)]
#![allow(unused_variables)]

use std::env;
use std::env::args;
use std::error::Error;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::stdin;
use std::io::Read;
use std::io::Write;
use std::ops::Index;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<(), Box<dyn Error>> {
    let surrounding_left: char = args()
        .nth(1)
        .and_then(|arg| arg.parse().ok())
        .unwrap_or('<');
    let surrounding_left = match surrounding_left {
        'b' => '(',
        'B' => '{',
        't' => '<',
        's' => '[',
        'p' => '|',
        other => other,
    };
    let surrounding_right: char = match surrounding_left {
        '(' => ')',
        '{' => '}',
        '<' => '>',
        '[' => ']',
        '|' => '|',
        _ => unimplemented!("(){{}}<>[]||"),
    };
    let mut the = String::new();
    let stdin = stdin()
        .read_to_string(&mut the)
        .expect("stdin");
    let left = the
        .find(surrounding_left)
        .expect("left delimiter");
    let right = the
        .rfind(surrounding_right)
        .expect("right delimiter");
    print!("{}", &the[(left + 1)..right]);
    Ok(())
}
