// begin Cargo.toml
// [dependencies]
// itertools = "0.14.0"
// # textwrap = "0.16.1"
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

use itertools::Itertools;

#[derive(PartialEq, Eq, Hash)]
enum Indent {
    Tab,
    Space(u32),
}

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
        "begin" => "end",
        _ => unimplemented!("(){{}}<>[]||"),
    };
    let stdins: Vec<String> = stdin()
        .lines()
        .map(Result::unwrap)
        .collect();
    stdins
        .iter()
        .filter(|&line| !line.trim().is_empty())
        .map(|line| {
            line.chars()
                .take_while(|&chr| chr == ' ' || chr == '\t')
                .collect::<String>()
        })
        .filter(|indent| !indent.is_empty())
        // TODO: should be a map + maybe collect
        .fold(Vec::new(), |mut decided_indent, line_indent| {
            let len = line_indent.len();
            if line_indent
                .chars()
                .any(|chr| chr == '\t')
            {
                decided_indent.push(Indent::Tab);
            } else if len % 4 == 0 {
                decided_indent.push(Indent::Space(4));
            } else if len % 2 == 0 {
                decided_indent.push(Indent::Space(2));
            } else if len % 3 == 0 {
                decided_indent.push(Indent::Space(3));
            } else {
                panic!("strange indentation")
            }
            decided_indent
        })
        .into_iter()
        .counts()
        .into_iter()
        .max_by_key(|&(_, likelyhood)| likelyhood)
        .map(|(result_indent, _)| result_indent)
        .unwrap_or(Indent::Space(4));
    // print!("{output}");
    Ok(())
}
