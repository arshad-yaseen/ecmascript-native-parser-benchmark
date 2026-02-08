# ECMAScript Native Parser Benchmark

Benchmark ECMAScript parsers implemented in native languages.

## System

| Property | Value |
|----------|-------|
| OS | Linux 6.11.0-1018-azure (x64) |
| CPU | AMD EPYC 7763 64-Core Processor |
| Cores | 4 |
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

### [TypeScript](https://github.com/arshad-yaseen/ecmascript-native-parser-benchmark/blob/main/files/typescript.js)

The TypeScript compiler source code bundled into a single file.

**File size:** 7.83 MB

![TypeScript Performance](charts/typescript.png)

| Parser | Mean | Min | Max |
|--------|------|-----|-----|
| Oxc | 79.23 ms | 78.48 ms | 80.31 ms |
| Yuku | 82.08 ms | 81.23 ms | 83.93 ms |
| SWC | 160.55 ms | 158.97 ms | 161.87 ms |
| Jam | 190.86 ms | 189.71 ms | 191.67 ms |

### [Three.js](https://github.com/arshad-yaseen/ecmascript-native-parser-benchmark/blob/main/files/three.js)

A popular 3D graphics library for the web.

**File size:** 1.96 MB

![Three.js Performance](charts/three.png)

| Parser | Mean | Min | Max |
|--------|------|-----|-----|
| Oxc | 17.46 ms | 17.03 ms | 18.11 ms |
| Yuku | 19.20 ms | 18.83 ms | 21.70 ms |
| SWC | 33.44 ms | 32.22 ms | 35.10 ms |
| Jam | 42.66 ms | 42.00 ms | 44.03 ms |

### [Ant Design](https://github.com/arshad-yaseen/ecmascript-native-parser-benchmark/blob/main/files/antd.js)

A popular React UI component library with enterprise-class design.

**File size:** 5.43 MB

![Ant Design Performance](charts/antd.png)

| Parser | Mean | Min | Max |
|--------|------|-----|-----|
| Yuku | 62.78 ms | 62.20 ms | 68.64 ms |
| Oxc | 62.98 ms | 62.02 ms | 64.31 ms |
| SWC | 122.91 ms | 121.64 ms | 124.66 ms |
| Jam | Failed to parse | - | - |

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