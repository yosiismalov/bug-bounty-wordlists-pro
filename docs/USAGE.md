# Bug Bounty Wordlists Pro — Usage Guide

Bug Bounty Wordlists Pro provides curated and generated wordlists for
authorized security testing.

## Requirements

- Linux
- Python 3
- Bash

## Installation

From the extracted package directory:

```bash
chmod +x scripts/install.sh
./scripts/install.sh
Ensure that the local binary directory is available in PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

For Bash, add it permanently:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## CLI commands

Display package statistics:

```bash
bbwp stats
```

List available wordlists:

```bash
bbwp list
```

Search all wordlists:

```bash
bbwp search tenant
```

Display one wordlist:

```bash
bbwp show ssrf/parameters
```

Export one wordlist:

```bash
bbwp export idor/generated-parameters \
  --output ~/idor-generated.txt
```

## Direct file usage

Use an API endpoint wordlist with ffuf:

```bash
ffuf \
  -u https://authorized-target.example/FUZZ \
  -w wordlists/api/endpoints.txt
```

Use an IDOR parameter list with Arjun:

```bash
arjun \
  -u https://authorized-target.example/api/profile \
  -w wordlists/idor/parameters.txt
```

The text files can also be loaded as payload lists in Burp Suite Intruder.

## Authorization

Only test systems that you own or systems for which you have explicit authorization.
