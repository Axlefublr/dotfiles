// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/prog/dotfiles/scripts/pueue-callback.rs
#![allow(unused_imports)]
#![allow(unused_variables)]
#![allow(dead_code)]

use std::env;
use std::env::args;
use std::error::Error;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::stdin;
use std::io::Read;
use std::io::Write;
use std::os::unix::process::CommandExt;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<(), Box<dyn Error>> {
    let mut args = args().skip(1);
    let id = args.next().unwrap_or_default();
    let command = args.next().unwrap_or_default();
    let path = args.next().unwrap_or_default();
    let success = args.next().unwrap_or_default();
    let exit_code = args.next().unwrap_or_default();
    let group = args.next().unwrap_or_default();
    let cmd_output = args.next().unwrap_or_default();
    let cmd_start = args.next().unwrap_or_default();
    let cmd_end = args.next().unwrap_or_default();

    // let command = command
    //     .split_whitespace()
    //     .next()
    //     .unwrap_or_default();

    let success_symbol = match &success[..] {
        "Success" => "",
        "Failed" => "󱎘",
        other => other,
    };

    // TODO: Success is checkmark, Failure is opposite; on single line
    // checkmark at end, not start
    let output = format!("{command} {success_symbol} ");

    Command::new("notify-send")
        .arg("-t")
        .arg("3000")
        .arg(output)
        .exec();
    Ok(())
}
