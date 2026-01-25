# ECMAScript Native Parser Benchmark

Benchmark ECMAScript parsers implemented in native languages.

## System

| Property | Value |
|----------|-------|
| OS | macOS 24.5.0 (arm64) |
| CPU | Apple M3 |
| Cores | 8 |
| Memory | 16 GB |

## Parsers

### [Yuku](https://github.com/arshad-yaseen/yuku)

**Language:** Zig

A high-performance & spec-compliant JavaScript/TypeScript compiler written in Zig.

### [Oxc](https://github.com/oxc-project/oxc)

**Language:** Rust

A high-performance JavaScript and TypeScript parser written in Rust.

### [SWC](https://github.com/swc-project/swc)

**Language:** Rust

An extensible Rust-based platform for compiling and bundling JavaScript and TypeScript.

### [Jam](https://github.com/srijan-paul/jam)

**Language:** Zig

A JavaScript toolchain written in Zig featuring a parser, linter, formatter, printer, and vulnerability scanner.

## Benchmarks

### TypeScript

The TypeScript compiler source code bundled into a single file.

**File size:** 7.83 MB

| Parser | Mean | Min | Max | MB/s |
|--------|------|-----|-----|------|
| Oxc | 29.04 ms | 28.35 ms | 29.59 ms | 269.58 MB/s |
| Yuku | 31.47 ms | 30.81 ms | 32.12 ms | 248.74 MB/s |
| Jam | 53.71 ms | 53.04 ms | 54.79 ms | 145.74 MB/s |
| SWC | 58.75 ms | 56.81 ms | 61.82 ms | 133.23 MB/s |

### Three.js

A popular 3D graphics library for the web.

**File size:** 1.96 MB

| Parser | Mean | Min | Max | MB/s |
|--------|------|-----|-----|------|
| Oxc | 7.60 ms | 7.15 ms | 8.23 ms | 258.40 MB/s |
| Yuku | 8.39 ms | 7.95 ms | 9.26 ms | 233.91 MB/s |
| Jam | 13.32 ms | 12.87 ms | 14.09 ms | 147.30 MB/s |
| SWC | 13.46 ms | 12.91 ms | 14.10 ms | 145.85 MB/s |

### Ant Design

A popular React UI component library with enterprise-class design.

**File size:** 5.43 MB

| Parser | Mean | Min | Max | MB/s |
|--------|------|-----|-----|------|
| Oxc | 24.29 ms | 23.87 ms | 24.67 ms | 223.52 MB/s |
| Yuku | 24.49 ms | 23.99 ms | 24.98 ms | 221.68 MB/s |
| SWC | 44.84 ms | 43.97 ms | 46.57 ms | 121.07 MB/s |
| Jam | Failed to parse | - | - | - |

## Run Benchmarks

### Prerequisites

- [Bun](https://bun.sh/) - JavaScript runtime and package manager
- [Rust](https://www.rust-lang.org/tools/install) - For building Rust-based parsers
- [Zig](https://ziglang.org/download/) - For building Zig-based parsers (requires nightly/development version)
- [Hyperfine](https://github.com/sharkdp/hyperfine) - Command-line benchmarking tool

### Steps

1. Clone the repository:

```bash
git clone https://github.com/arshad-yaseen/ecmascript-native-parser-benchmark.git
cd ecmascript-native-parser-benchmark
```

2. Install dependencies:

```bash
bun install
```

3. Run benchmarks:

```bash
bun bench
```

This will build all parsers and run benchmarks on all test files. Results are saved to the `result/` directory.

## Methodology

### How Benchmarks Are Conducted

1. **Build Phase**: All parsers are compiled with release optimizations:
   - Rust parsers: `cargo build --release` with LTO, single codegen unit, and symbol stripping
   - Zig parsers: `zig build --release=fast`

2. **Benchmark Phase**: Each parser is benchmarked using [Hyperfine](https://github.com/sharkdp/hyperfine):
   - 100 warmup runs to ensure stable measurements
   - Multiple timed runs for statistical accuracy
   - Results exported to JSON for analysis

3. **Measurement**: Each benchmark measures the total time to:
   - Read the source file from disk
   - Parse the entire file into an AST
   - Clean up allocated memory

### Test Files

The benchmark uses real-world JavaScript files from popular open-source projects to ensure results reflect practical performance characteristics.