// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/prog/dotfiles/scripts/fool/pueue.rs
#![allow(unused_imports)]
#![allow(unused_variables)]
#![allow(dead_code)]

use std::env::args;
use std::env::Args;
use std::env::{self};
use std::error::Error;
use std::ffi::OsStr;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::stdin;
use std::io::Read;
use std::io::Write;
use std::iter::Skip;
use std::os::unix::process::CommandExt;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

fn main() -> Result<(), Box<dyn Error>> {
    let mut args = args().skip(1);
    let mut cmd = Command::new("/usr/bin/pueue");

    fn etc(mut cmd: Command) -> ! {
        cmd.exec();
        unreachable!("process didn't transfer as expected");
    }

    let Some(subcommand) = args.next() else {
        let mut cmd = Command::new("ov");
        cmd.args([
            "--section-delimiter",
            "^Group",
            "-M",
            "Failed,Running,Queued,Success,,,,Paused",
            "-e",
            "--",
            "/usr/bin/pueue",
        ]);
        etc(cmd)
    };

    match &subcommand[..] {
        "g" => {
            cmd.arg("group");
        },
        "cl" => {
            cmd.arg("clean");
        },
        "cls" => {
            cmd.arg("clean").arg("-s");
        },
        "ll" => {
            cmd.arg("parallel");
        },
        "u" => {
            cmd.arg("pause");
        },
        "r" => {
            cmd.arg("start");
        },
        "s" => {
            cmd.arg("status");
        },
        "l" => {
            cmd.arg("log");
        },
        "a" => {
            cmd.arg("add");
        },
        other => {
            cmd.arg(other);
        },
    }
    cmd.args(args);
    cmd.exec();
    Ok(())
}
