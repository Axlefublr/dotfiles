// begin Cargo.toml
// [dependencies]
// clap = { version = "4.5.32", features = ["derive", "wrap_help"] }
// anyhow = "1.0.97"
// dirs = "6.0.0"
// end Cargo.toml
// /home/axlefublr/fes/dot/scripts/sj.rs
#![allow(unused_imports)]
#![allow(unused_variables)]
#![allow(dead_code)]

use std::cmp::Ordering;
use std::env;
use std::error::Error;
use std::fmt;
use std::fs;
use std::fs::DirEntry;
use std::fs::File;
use std::fs::OpenOptions;
use std::io;
use std::io::Read;
use std::io::Write;
use std::path::Path;
use std::path::PathBuf;
use std::process::Command;
use std::time::SystemTime;

use anyhow::Context;
use anyhow::Result;
use clap::Parser;

#[derive(Parser)]
struct Nuts {
    #[arg(short, long)]
    innards: bool,
    #[arg(short = 'e', long)]
    hide_empty: bool,
    #[arg(short, long)]
    basename: bool,
    dirs: Vec<PathBuf>,
}

struct Project {
    path: PathBuf,
    contents: Option<String>,
}

impl Project {
    fn modified_date(&self) -> anyhow::Result<SystemTime> {
        let mut the = self.path.clone();
        the.push("project.txt");
        Ok(fs::metadata(the)?.modified()?)
    }
}

impl TryFrom<DirEntry> for Project {
    type Error = anyhow::Error;

    fn try_from(entry: DirEntry) -> Result<Self, Self::Error> {
        let path = entry.path();
        let mut project_path = path.clone();
        project_path.push("project.txt");
        let mut file = OpenOptions::new()
            .create(true)
            .read(true)
            .truncate(false)
            .append(true)
            .open(project_path)
            .context("opening project.txt")?;
        let mut buf = String::new();
        file.read_to_string(&mut buf)?;
        let contents = if buf.is_empty() { None } else { Some(buf) };
        Ok(Self { path, contents })
    }
}

fn main() -> anyhow::Result<()> {
    let nuts = Nuts::parse();
    let entries = nuts
        .dirs
        .into_iter()
        .map(|dir| dir.read_dir())
        .collect::<Result<Vec<_>, _>>()
        .context("reading specified directories")?
        .into_iter()
        .flatten()
        .collect::<Result<Vec<_>, _>>()
        .context("io operations of getting each DirEntry")?;
    let mut projects = entries
        .into_iter()
        .map(Project::try_from)
        .collect::<Result<Vec<_>, _>>()?;
    projects.sort_by(|first, second| {
        if let Ok(date) = first.modified_date() {
            if let Ok(date2) = second.modified_date() {
                date.cmp(&date2)
            } else {
                Ordering::Greater
            }
        } else {
            Ordering::Greater
        }
    });
    projects.reverse();
    for project in projects {
        if nuts.hide_empty && project.contents.is_none() {
            continue;
        }
        if nuts.basename {
            println!("{}:", project.path.file_name().unwrap().to_string_lossy())
        } else {
            let path = project
                .path
                .strip_prefix({
                    let mut the = dirs::home_dir().unwrap();
                    the.push("r");
                    the
                })
                .context("strip prefix")?;
            println!("{}", path.display())
        }
        if nuts.innards {
            if let Some(innards) = project.contents {
                println!("{}", innards);
            }
        }
    }
    Ok(())
}
