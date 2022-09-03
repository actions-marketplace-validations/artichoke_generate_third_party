# generate_third_party

[![GitHub Actions](https://github.com/artichoke/generate_third_party/workflows/CI/badge.svg)](https://github.com/artichoke/generate_third_party/actions)
[![Discord](https://img.shields.io/discord/607683947496734760)](https://discord.gg/QCe2tp2)
[![Twitter](https://img.shields.io/twitter/follow/artichokeruby?label=Follow&style=social)](https://twitter.com/artichokeruby)

Generate listings of third party dependencies and their licenses for copyright
attribution in distributed Artichoke binaries.

## Usage

To generate a `THIRDPARTY` text file for all targets Artichoke supports:

```sh
bundle exec generate-third-party-text-file path/to/artichoke/Cargo.toml
```

To generate a `THIRDPARTY` text file for a single target triple:

```sh
bundle exec generate-third-party-text-file-single-target x86_64-unknown-linux-gnu path/to/artichoke/Cargo.toml
```

### GitHub Actions

This repository is available as a GitHub Action:

```yaml
- name: Generate THIRDPARTY license listing
  id: generate_third_party
  uses: artichoke/generate_third_party@trunk
  with:
    artichoke_ref: trunk
    target_triple: x86_64-unknown-linux-gnu
    output_file: ${{ github.workspace }}/THIRDPARTY
```

## Supported Targets

- aarch64-apple-darwin
- x86_64-apple-darwin
- x86_64-pc-windows-msvc
- x86_64-unknown-linux-gnu
- x86_64-unknown-linux-musl
