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
use std::ops::Range;
use std::ops::RangeBounds;
use std::ops::RangeFrom;
use std::ops::RangeTo;
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
    trait RangeLike {
        fn contains(&self, item: &i32) -> bool;
    }
    impl RangeLike for Range<i32> {
        fn contains(&self, item: &i32) -> bool {
            self.contains(item)
        }
    }
    impl RangeLike for RangeFrom<i32> {
        fn contains(&self, item: &i32) -> bool {
            self.contains(item)
        }
    }
    enum RangeInclusivity {
        Inclusive(Box<dyn RangeLike>),
        Negating(Box<dyn RangeLike>),
    }
    let ranges: Vec<_> = args
        .map(|arg| {
            let mut modify_start = 1;
            let mut modify_end = 1;
            let negating_range;
            let arg = if let Some(arg) = arg.strip_prefix(',') {
                modify_start -= 1;
                modify_end -= 1;
                arg
            } else {
                arg.as_str()
            };
            let arg = if let Some(arg) = arg.strip_prefix('^') {
                negating_range = true;
                arg
            } else {
                negating_range = false;
                arg
            };
            let (first_bound, second_bound) = if let Some((first_bound, second_bound)) = arg.split_once("..=")
            {
                modify_end -= 1;
                (first_bound, second_bound)
            } else if let Some((first_bound, second_bound)) = arg.split_once("..") {
                (first_bound, second_bound)
            } else {
                modify_end -= 1;
                (arg, arg)
            };
            let first_bound = if let Ok(first_bound) = first_bound.parse::<i32>() {
                first_bound - modify_start
            } else {
                0
            };
            let second_bound: Option<i32> = second_bound
                .parse::<i32>()
                .ok()
                .map(|bound| bound - modify_end);
            if negating_range {
                if let Some(second_bound) = second_bound {
                    RangeInclusivity::Negating(Box::new(first_bound..second_bound))
                } else {
                    RangeInclusivity::Negating(Box::new(first_bound..))
                }
            } else if let Some(second_bound) = second_bound {
                RangeInclusivity::Inclusive(Box::new(first_bound..second_bound))
            } else {
                RangeInclusivity::Inclusive(Box::new(first_bound..))
            }
        })
        .collect();
    'outer: for (index, line) in input.into_iter().enumerate() {
        for range in &ranges {
            match range {
                RangeInclusivity::Inclusive(range) => {
                    if range.contains(&(index as i32)) {
                        println!("{}", line);
                    }
                },
                RangeInclusivity::Negating(range) => {
                    if range.contains(&(index as i32)) {
                        continue 'outer;
                    }
                },
            };
        }
    }
    Ok(())
}
