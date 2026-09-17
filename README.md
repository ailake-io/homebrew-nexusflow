# homebrew-nexusflow

Homebrew tap for [NexusFlow](https://github.com/ailake-io/nexusflow) — a
universal Rust data & vector framework (ETL/ELT/streaming + AI Lakehouse
Builder).

## Install

```bash
brew tap ailake-io/nexusflow
brew install nexusflow
```

or in one line:

```bash
brew install ailake-io/nexusflow/nexusflow
```

Apple Silicon (arm64) only — no Intel (x86_64) build exists yet.

## Updating the formula for a new release

`Formula/nexusflow.rb`'s `url`/`sha256` need to be bumped by hand for
each release (no automation yet — a real follow-up would be
`brew bump-formula-pr` wired into `.github/workflows/release.yml` or
`build-macos-installer.yml`):

```bash
gh release download vX.Y.Z --repo ailake-io/nexusflow --pattern "nexusflow-macos-arm64.tar.gz"
sha256sum nexusflow-macos-arm64.tar.gz
# update url (vX.Y.Z) and sha256 in Formula/nexusflow.rb, commit, push
```
