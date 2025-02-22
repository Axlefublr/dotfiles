// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/zat.rs
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
use std::ops::RangeBounds;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

// filepath or -, all other args are ranges
fn main() -> Result<(), Box<dyn Error>> {
    let mut args = env::args();
    let input_pointer = args.by_ref().nth(1).unwrap();
    let input: Vec<String> = {
        if &input_pointer[..] == "-" {
            io::stdin()
                .lines()
                .map(Result::unwrap)
                .collect()
        } else {
            let contents = fs::read_to_string(PathBuf::from(input_pointer)).unwrap();
            contents
                .lines()
                .map(str::to_owned)
                .collect()
        }
    };
    let closures: Vec<_> = args
        .map(|arg| {
            let mut subtract = 0;
            let negating_range;
            let arg = if let Some(arg) = arg.strip_prefix('^') {
                negating_range = true;
                arg
            } else {
                negating_range = false;
                arg.as_str()
            };
            let (first_bound, second_bound) = arg
                .split_once("..=")
                .unwrap_or_else(|| {
                    subtract = 1;
                    arg.split_once("..").unwrap()
                });
            let first_bound: usize = first_bound.parse().unwrap();
            let second_bound: usize = second_bound.parse().unwrap();
            move |index: usize| {
                let includes = ((first_bound - 1)..(second_bound - subtract)).contains(&index);
                if negating_range {
                    !includes
                } else {
                    includes
                }
            }
        })
        .collect();
    'outer: for (index, line) in input.into_iter().enumerate() {
        for closure in &closures {
            if closure(index) {
                println!("{}", line);
                continue 'outer;
            }
        }
    }
    Ok(())
}
