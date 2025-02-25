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
use std::ops::Bound;
use std::ops::Range;
use std::ops::RangeBounds;
use std::ops::RangeFrom;
use std::ops::RangeTo;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;
use std::str::FromStr;

#[derive(PartialEq, Debug)]
struct LineRange {
    start: usize,
    end: Option<usize>,
    negated: bool,
}

impl FromStr for LineRange {
    type Err = &'static str;

    fn from_str(arg: &str) -> Result<Self, Self::Err> {
        let (arg, zero_indexed) = arg
            .strip_prefix(',')
            .map(|arg| (arg, true))
            .unwrap_or((arg, false));
        let (arg, negated) = arg
            .strip_prefix('^')
            .map(|arg| (arg, true))
            .unwrap_or((arg, false));

        let (first, second) = if let Some((first, second)) = arg.split_once("..") {
            (first, second)
        } else {
            (arg, arg)
        };

        let start = first
            .parse::<usize>()
            .ok()
            .map(|the| if zero_indexed { the } else { the.saturating_sub(1) })
            .unwrap_or(0);
        let end = second
            .parse::<usize>()
            .ok()
            .map(|the| if zero_indexed { the } else { the.saturating_sub(1) });

        Ok(Self { negated, start, end })
    }
}

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
    let ranges: Vec<_> = args
        .map(|arg| LineRange::from_str(&arg).unwrap())
        .collect();
    'outer: for (index, line) in input.into_iter().enumerate() {
        for range in &ranges {
            if range.negated {
                if let Some(end) = range.end {
                    if range.start <= index && end >= index {
                        continue 'outer;
                    }
                } else if range.start <= index {
                    continue 'outer;
                }
            } else if let Some(end) = range.end {
                if range.start <= index && end >= index {
                    println!("{}", line);
                    continue 'outer;
                }
            } else if range.start <= index {
                println!("{}", line);
                continue 'outer;
            }
        }
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn normal() {
        assert_eq!(
            LineRange {
                start: 0,
                end: Some(4),
                negated: false
            },
            "1..5".parse().unwrap()
        )
    }

    #[test]
    fn index() {
        assert_eq!(
            LineRange {
                start: 0,
                end: Some(4),
                negated: false
            },
            ",0..4".parse().unwrap()
        )
    }

    #[test]
    fn negated() {
        assert_eq!(
            LineRange {
                start: 0,
                end: Some(4),
                negated: true
            },
            "^1..5".parse().unwrap()
        )
    }

    #[test]
    fn both() {
        assert_eq!(
            LineRange {
                start: 0,
                end: Some(4),
                negated: true
            },
            ",^0..4".parse().unwrap()
        )
    }

    #[test]
    fn from() {
        assert_eq!(
            LineRange {
                start: 0,
                end: None,
                negated: false
            },
            "1..".parse().unwrap()
        )
    }

    #[test]
    fn to() {
        assert_eq!(
            LineRange {
                start: 0,
                end: Some(4),
                negated: false
            },
            "..5".parse().unwrap()
        )
    }

    #[test]
    fn from_negated() {
        assert_eq!(
            LineRange {
                start: 0,
                end: None,
                negated: true
            },
            "^1..".parse().unwrap()
        )
    }

    #[test]
    fn from_index() {
        assert_eq!(
            LineRange {
                start: 0,
                end: None,
                negated: false
            },
            ",0..".parse().unwrap()
        )
    }

    #[test]
    fn to_index() {
        assert_eq!(
            LineRange {
                start: 0,
                end: Some(4),
                negated: false
            },
            ",..4".parse().unwrap()
        )
    }

    #[test]
    fn from_index_negated() {
        assert_eq!(
            LineRange {
                start: 0,
                end: None,
                negated: true
            },
            ",^0..".parse().unwrap()
        )
    }

    #[test]
    fn to_index_negated() {
        assert_eq!(
            LineRange {
                start: 0,
                end: Some(4),
                negated: true
            },
            ",^..4".parse().unwrap()
        )
    }

    #[test]
    fn single() {
        assert_eq!(
            LineRange {
                start: 2,
                end: Some(2),
                negated: false
            },
            "3".parse().unwrap()
        )
    }

    #[test]
    fn single_index() {
        assert_eq!(
            LineRange {
                start: 3,
                end: Some(3),
                negated: false
            },
            ",3".parse().unwrap()
        )
    }

    #[test]
    fn single_negated() {
        assert_eq!(
            LineRange {
                start: 2,
                end: Some(2),
                negated: true
            },
            "^3".parse().unwrap()
        )
    }

    #[test]
    fn single_index_negated() {
        assert_eq!(
            LineRange {
                start: 3,
                end: Some(3),
                negated: true
            },
            ",^3".parse().unwrap()
        )
    }
}
