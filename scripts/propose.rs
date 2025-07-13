// begin Cargo.toml
// [dependencies]
// clap = { version = "4.5.36", features = ["derive"] }
// anyhow = "1.0.98"
// serde = { version = "1.0.219", features = ["derive"] }
// serde_json = "1.0.140"
// rand = "0.9.0"
// dirs = "6.0.0"
// end Cargo.toml
// /home/axlefublr/fes/dot/scripts/propose.rs
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
use std::io::stdin;
use std::io::BufRead;
use std::io::BufReader;
use std::io::Read;
use std::io::Seek;
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;
use std::str::FromStr;
use std::{collections::HashMap, ops::Not};

use anyhow::Context;
use clap::Parser;
use rand::seq::IteratorRandom;
use rand::Rng;

#[derive(Parser)]
struct Octopus {
    #[arg(short = 'n', long)]
    lines: Option<Consideration>,
    cache_name: String,
    consider: Consideration,
    path: PathBuf,
}

#[derive(Clone, Copy, Debug)]
enum Consideration {
    Number(usize),
    Percentage(u8),
}

impl FromStr for Consideration {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        if let Ok(number) = s.parse() {
            Ok(Self::Number(number))
        } else {
            Ok(Self::Percentage(s[..(s.len() - 1)].parse()?))
        }
    }
}

fn main() -> anyhow::Result<()> {
    let octopus = Octopus::parse();
    let mut carpholder = OpenOptions::new()
        .read(true)
        .write(true)
        .truncate(false)
        .create(true)
        .open({
            let mut the = dirs::cache_dir().unwrap();
            the.push("propose.rs.jsonc");
            the
        })
        .unwrap();
    let mut buf = String::new();
    carpholder.read_to_string(&mut buf).unwrap();
    let mut carp: HashMap<String, Vec<String>> = serde_json::from_str(&buf).unwrap_or_default();
    let carplet = carp.entry(octopus.cache_name).or_default(); // carpet made of carps
    let mut rng = rand::rng();
    let mut input_file = OpenOptions::new()
        .read(true)
        .create(false)
        .open(octopus.path)
        .context("input file doesn't exist")?;
    let mut contents = String::new();
    input_file.read_to_string(&mut contents).unwrap();
    let lines = contents.lines();
    let line_count = lines.clone().count();
    let starting_index = match octopus.consider {
        Consideration::Number(num) => carplet.len().saturating_sub(num),
        Consideration::Percentage(percentage) => carplet
            .len()
            .saturating_sub(line_count * percentage as usize / 100),
    };
    let mut pickable_lines =
        lines.filter(|&line| !carplet[starting_index..].contains(&line.to_owned()));
    let picked_lines = pickable_lines.clone().by_ref().choose_multiple(
        &mut rng,
        match octopus.lines.unwrap_or(Consideration::Number(1)) {
            Consideration::Number(num) => num,
            Consideration::Percentage(perc) => pickable_lines.count() * perc as usize / 100,
        },
    );
    if picked_lines.is_empty().not() {
        println!("{}", picked_lines.join("\n"));
        carplet.append(&mut picked_lines.into_iter().map(ToOwned::to_owned).collect());
    }
    let carplet_len = carplet.len();
    if carplet_len > line_count {
        carplet.drain(..(carplet_len - line_count));
    }
    let prac = serde_json::to_string_pretty(&carp).unwrap();
    carpholder.set_len(0).unwrap();
    carpholder.rewind().unwrap();
    carpholder.write_all(prac.as_bytes()).unwrap();
    Ok(())
}
