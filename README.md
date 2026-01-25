# ECMAScript Native Parser Benchmark

Benchmark ECMAScript parsers implemented in native languages.

## System

| Property | Value |
|----------|-------|
| OS | macOS 24.6.0 (arm64) |
| CPU | Apple M1 (Virtual) |
| Cores | 3 |
| Memory | 7 GB |

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
| Yuku | 46.29 ms | 33.24 ms | 80.79 ms | 169.10 MB/s |
| Oxc | 52.85 ms | 33.46 ms | 75.21 ms | 148.10 MB/s |
| SWC | 132.98 ms | 113.24 ms | 150.30 ms | 58.86 MB/s |
| Jam | 171.18 ms | 91.24 ms | 277.82 ms | 45.73 MB/s |

### Three.js

A popular 3D graphics library for the web.

**File size:** 1.96 MB

| Parser | Mean | Min | Max | MB/s |
|--------|------|-----|-----|------|
| Yuku | 11.23 ms | 3.83 ms | 25.14 ms | 174.81 MB/s |
| Oxc | 12.32 ms | 4.66 ms | 82.84 ms | 159.35 MB/s |
| SWC | 27.71 ms | 10.30 ms | 109.42 ms | 70.84 MB/s |
| Jam | 28.49 ms | 10.11 ms | 107.06 ms | 68.89 MB/s |

### Ant Design

A popular React UI component library with enterprise-class design.

**File size:** 5.43 MB

| Parser | Mean | Min | Max | MB/s |
|--------|------|-----|-----|------|
| Yuku | 42.72 ms | 22.26 ms | 86.66 ms | 127.08 MB/s |
| Oxc | 49.53 ms | 29.64 ms | 83.78 ms | 109.59 MB/s |
| SWC | 87.80 ms | 62.54 ms | 118.91 ms | 61.82 MB/s |

## Run Benchmarks

### Prerequisites

- [Bun](https://bun.sh/) - JavaScript runtime and package manager
- [Rust](https://www.rust-lang.org/tools/install) - For building Rust-based parsers
- [Zig](https://ziglang.org/download/) - For building Zig-based parsers
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