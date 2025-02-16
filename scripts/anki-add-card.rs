// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/anki-add-card.rs
#![allow(unused_imports)]
#![allow(unused_variables)]
#![allow(dead_code)]

use std::env;
use std::env::args;
use std::error::Error;
use std::fmt;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::stdin;
use std::io::Read;
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

const VALID_DECKS: [&str; 2] = ["Once", "Freq"];
const VALID_NOTE_TYPES: [&str; 5] = ["b", "d", "f", "fb", "h"];

fn main() -> Result<(), Box<dyn Error>> {
    let contents = fs::read_to_string("/home/axlefublr/.cache/mine/anki-card.html").expect("read card file");
    let mut lines = contents.lines().map(str::trim);

    let deck = lines.next().unwrap();
    if !VALID_DECKS.contains(&deck) {
        Err("invalid deck")?;
    }
    let note_type = lines.next().unwrap();
    if !VALID_NOTE_TYPES.contains(&note_type) {
        Err("invalid note type")?;
    }

    let mut lines: Vec<_> = lines.collect();
    lines.insert(0, note_type);
    lines.insert(0, deck);

    let fields = lines.len();
    if !(4..=6).contains(&fields) {
        Err(format!("expected 4..=6 fields, got {}", fields))?;
    }

    lines.resize(6, "");

    let card = lines
        .into_iter()
        .map(|line| format!("\"{}\"", line.replace('"', "\"\"")))
        .collect::<Vec<_>>()
        .join("|");
    println!("{}", card);
    Ok(())
}
