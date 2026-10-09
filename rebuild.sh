#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ln -sfn "$DIR" ~/.dotfiles
# exec sudo darwin-rebuild switch --flake ~/.dotfiles#mac
# `--preserve-env`` pass env vars to sudo
exec sudo --preserve-env=ALL_PROXY,HTTPS_PROXY darwin-rebuild switch --flake ~/.dotfiles#mac