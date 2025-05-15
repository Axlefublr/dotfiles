// begin Cargo.toml
// [dependencies]
// itertools = "0.14.0"
// end Cargo.toml
// /home/axlefublr/r/dot/scripts/wrap-in-block.rs
#![allow(unused_imports)]
#![allow(unused_variables)]

use std::env::args;
use std::error::Error;
use std::fmt;
use std::fmt::Write;
use std::fs;
use std::fs::File;
use std::fs::OpenOptions;
use std::io::stdin;
use std::io::Read;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;
use std::{env, ops::Not};

use itertools::Itertools;

#[derive(PartialEq, Eq, Hash)]
enum Indent {
    Tab,
    Space(usize),
}

impl Default for Indent {
    fn default() -> Self {
        Self::Space(4)
    }
}

impl fmt::Display for Indent {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Tab => write!(f, "\t"),
            Self::Space(how_many) => write!(f, "{}", " ".repeat(*how_many)),
        }
    }
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
        "`" => "```",
        "\"" => r#"""""#,
        other => other,
    };
    let surrounding_right = match surrounding_left {
        "(" => ")",
        "{" => "}",
        "<" => ">",
        "[" => "]",
        "|" => "|",
        "begin" => "end",
        "```" => "```",
        r#"""""# => r#"""""#,
        _ => unimplemented!("(){{}}<>[]||"),
    };
    let no_indent_innards = [r#"""""#, "```"];
    let stdins: Vec<String> = stdin().lines().map(Result::unwrap).collect();

    let indentations = stdins
        .iter()
        .filter(|&line| !line.trim().is_empty())
        .map(|line| {
            line.chars()
                .take_while(|&chr| chr == ' ' || chr == '\t')
                .collect::<String>()
        });

    let indent_type = indentations
        .clone()
        .filter(|indent_of_line| !indent_of_line.is_empty())
        .map(|line_indent| {
            let len = line_indent.len();
            if line_indent.chars().any(|chr| chr == '\t') {
                Indent::Tab
            } else if len % 4 == 0 {
                Indent::Space(4)
            } else if len % 2 == 0 {
                Indent::Space(2)
            } else if len % 3 == 0 {
                Indent::Space(3)
            } else {
                Indent::default()
            }
        })
        .counts()
        .into_iter()
        .max_by_key(|&(_, likelyhood)| likelyhood)
        .map(|(result_indent, _)| result_indent)
        .unwrap_or(Indent::default());

    let indent_chars = indent_type.to_string();

    let minimum_indent_level = indentations
        .map(|indent_line| {
            let mut count = 0;
            let mut indent_line = indent_line.as_str();
            while let Some(rest) = indent_line.strip_prefix(&indent_chars) {
                count += 1;
                indent_line = rest;
            }
            count
        })
        .min()
        .unwrap_or_default();

    let mut output = String::new();
    output.push_str(&indent_chars.repeat(minimum_indent_level));
    output.push_str(surrounding_left);
    output.push('\n');
    let source = stdins
        .into_iter()
        .fold(String::new(), |mut collector: String, line| {
            if !no_indent_innards.contains(&surrounding_left) {
                collector.push_str(&indent_chars);
            }
            collector.push_str(&line);
            collector.push('\n');
            collector
        });
    output.push_str(&source);
    output.push_str(&indent_chars.repeat(minimum_indent_level));
    output.push_str(surrounding_right);
    output.push('\n');
    print!("{output}");
    Ok(())
}
