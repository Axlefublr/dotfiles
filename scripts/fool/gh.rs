// begin Cargo.toml
// [dependencies]
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/fool/gh.rs
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
    let mut cmd = Command::new("/usr/bin/gh");

    fn etc(mut cmd: Command) -> ! {
        cmd.exec();
        unreachable!();
    }

    fn blammo(cmd: &mut Command, args: &mut Skip<Args>) {
        for argument in args {
            cmd.arg(argument);
        }
    }

    let Some(subcommand) = args.next() else { etc(cmd) };
    cmd.arg(&subcommand);

    match &subcommand[..] {
        "repo" => {
            let Some(next_arg) = args.next() else { etc(cmd) };

            match &next_arg[..] {
                "forkf" => {
                    cmd.arg("fork");
                    blammo(&mut cmd, &mut args);
                    cmd.arg("--clone")
                        .arg("--default-branch-only");
                },
                other => {
                    cmd.arg(other);
                    blammo(&mut cmd, &mut args)
                },
            }
        },
        other => blammo(&mut cmd, &mut args),
    }
    cmd.exec();
    Ok(())
}
