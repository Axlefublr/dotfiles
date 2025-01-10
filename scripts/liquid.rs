// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/prog/dotfiles/scripts/liquid.rs
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
use std::ops::Add;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

const ML_PER_DAY: f32 = 11.4;

fn main() -> Result<(), Box<dyn Error>> {
    let total_ml = args()
        .skip(1)
        .map(|arg| {
            let mut split = arg.split('/');
            let current_cm = split
                .next()
                .unwrap()
                .parse::<f32>()
                .unwrap();
            let max_cm = split
                .next()
                .unwrap()
                .parse::<f32>()
                .unwrap();
            let max_ml = split
                .next()
                .unwrap()
                .parse::<f32>()
                .unwrap();
            let ratio = current_cm / max_cm;
            max_ml * ratio
        })
        .sum::<f32>();
    let lasts_days = total_ml / ML_PER_DAY;
    println!("Total: {:.2}ml", total_ml);
    println!("Lasts: {:.2} days", lasts_days);
    Ok(())
}
