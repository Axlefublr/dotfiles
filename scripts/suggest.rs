// begin Cargo.toml
// [dependencies]
// clap = { version = "4.5.32", features = ["derive", "wrap_help"] }
// serde = { version = "1.0.219", features = ["derive"] }
// serde_json = "1.0.140"
// dirs = "6.0.0"
// rand = "0.9.0"
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/suggest.rs
#![allow(unused_imports)]
#![allow(unused_variables)]
#![allow(dead_code)]

use std::collections::HashMap;
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
use rand::seq::IndexedRandom;
use rand::seq::SliceRandom;
use serde::Deserialize;
use serde::Serialize;

#[derive(Parser)]
struct Nuts {
    namespace: String,
    path: PathBuf,
}

type JsonSchema = HashMap<String, HashMap<String, i32>>;

fn main() -> Result<(), Box<dyn Error>> {
    let nuts = Nuts::parse();
    let cache_path = {
        let mut the = dirs::cache_dir().unwrap();
        the.push("suggest.rs.jsonc");
        the
    };
    let mut cache_file = OpenOptions::new()
        .read(true)
        .truncate(false)
        .write(true)
        .create(true)
        .open(cache_path)
        .unwrap();
    let mut cache = String::new();
    cache_file
        .read_to_string(&mut cache)
        .unwrap();
    let mut json_schema: JsonSchema = serde_json::from_str(&cache).unwrap_or_default();

    let entry = json_schema
        .entry(nuts.namespace)
        .or_default();
    let contents = fs::read_to_string(nuts.path).unwrap();
    let lines = contents.lines();

    let lowest_count = lines
        .clone()
        .map(|line| {
            *entry
                .entry((*line).to_owned())
                .or_default()
        })
        .min()
        .expect("creating entries for all lines and filling them with 0");
    let lines: Vec<String> = lines
        .filter(|line| {
            entry
                .get(line.to_owned())
                .map(|count| count <= &lowest_count)
                .unwrap()
        })
        .map(ToOwned::to_owned)
        .collect();

    let mut rng = rand::rng();
    let picked_line = lines
        .choose(&mut rng)
        .unwrap()
        .to_owned();
    println!("{}", picked_line);
    entry
        .entry(picked_line)
        .and_modify(|value| *value += 1)
        .or_insert(1);

    let cache = serde_json::to_string_pretty(&json_schema).unwrap();
    cache_file.set_len(0).unwrap();
    cache_file.rewind().unwrap();
    cache_file
        .write_all(cache.as_bytes())
        .unwrap();
    Ok(())
}
