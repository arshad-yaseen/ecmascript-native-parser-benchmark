#![expect(clippy::print_stdout)]

use std::{fs, path::PathBuf};

use oxc_allocator::Allocator;
use oxc_parser::{ParseOptions, Parser};
use oxc_span::SourceType;
use pico_args::Arguments;

fn main() -> Result<(), String> {
    let mut args = Arguments::from_env();

    let path: PathBuf = args
        .free_from_str()
        .map_err(|_| "Usage: oxc <file_path>".to_string())?;

    if path.is_dir() {
        parse_directory(&path)?;
    } else {
        parse_file(&path)?;
    }

    Ok(())
}

fn parse_directory(dir: &PathBuf) -> Result<(), String> {
    let entries = fs::read_dir(dir)
        .map_err(|e| format!("Failed to read directory '{}': {}", dir.display(), e))?;

    for entry in entries {
        let entry = entry.map_err(|e| format!("Failed to read entry: {}", e))?;
        let path = entry.path();

        if path.is_dir() {
            parse_directory(&path)?;
        } else if path.is_file() {
            let _ = parse_file(&path);
        }
    }

    Ok(())
}

fn parse_file(path: &PathBuf) -> Result<(), String> {
    let source_text = fs::read_to_string(path)
        .map_err(|e| format!("Failed to read file '{}': {}", path.display(), e))?;

    let source_type = SourceType::from_path(path).unwrap();

    let allocator = Allocator::default();

    Parser::new(&allocator, &source_text, source_type)
        .with_options(ParseOptions {
            parse_regular_expression: true,
            ..ParseOptions::default()
        })
        .parse();

    Ok(())
}
