// begin Cargo.toml
// [dependencies]
// textwrap = "0.16.1"
// # clap = { version = "4.5.23", features = ["wrap_help", "derive"] }
// end Cargo.toml
// /home/axlefublr/prog/dotfiles/scripts/wrap-in-block.rs
#![allow(unused_imports)]
#![allow(unused_variables)]

use std::env;
use std::env::args;
use std::error::Error;
use std::fmt::Write;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::stdin;
use std::io::Read;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;

use textwrap::dedent;

fn main() -> Result<(), Box<dyn Error>> {
    let surrounding_left: String = args()
        .nth(1)
        .and_then(|arg| arg.parse().ok())
        .unwrap_or("{".into());
    let surrounding_left = match &surrounding_left[..] {
        "b" => "(",
        "B" => "{",
        "t" => "<",
        "s" => "[",
        "p" => "|",
        other => other,
    };
    let surrounding_right = match surrounding_left {
        "(" => ")",
        "{" => "}",
        "<" => ">",
        "[" => "]",
        "|" => "|",
        "do" => "end",
        "begin" => "end",
        "then" => "end",
        _ => unimplemented!("(){{}}<>[]||"),
    };
    let mut output = String::new();
    output.push_str(surrounding_left);
    output.push('\n');
    let mut buf = String::new();
    stdin()
        .read_to_string(&mut buf)
        .expect("read stdin");
    let buf: String = dedent(&buf)
        .lines()
        .fold(String::new(), |mut text, line| {
            writeln!(text, "    {line}").unwrap();
            text
        });
    output.push_str(&buf);
    output.push_str(surrounding_right);
    output.push('\n');
    print!("{output}");
    Ok(())
}
