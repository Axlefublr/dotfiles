// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/fool/qrtool.rs
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
use std::os::unix::process::CommandExt;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<(), Box<dyn Error>> {
    let mut args = args().skip(1);
    let mut cmd = Command::new("/usr/bin/qrtool");

    fn etc(mut cmd: Command) -> ! {
        panic!("{}", cmd.exec());
    }

    let Some(subcommand) = args.next() else {
        etc(cmd);
    };

    match &subcommand[..] {
        "c" => {
            cmd.args(["encode", "-m", "1", "--optimize-png", "4"]);
            cmd.args(args);
            etc(cmd);
        },
        "t" => {
            cmd.args(["encode", "-m", "1", "-t", "terminal"]);
            cmd.args(args);
            etc(cmd);
        },
        other => {
            cmd.arg(other);
        },
    }
    cmd.args(args);
    etc(cmd);
}
