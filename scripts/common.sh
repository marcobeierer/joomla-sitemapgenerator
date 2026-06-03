#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

fail() {
	printf 'Error: %s\n' "$*" >&2
	exit 1
}

require_command() {
	local command_name="$1"

	command -v "$command_name" >/dev/null 2>&1 || fail "Required command not found: $command_name"
}

absolute_path() {
	local path="$1"
	local dir

	dir="$(cd "$(dirname "$path")" && pwd)"
	printf '%s/%s\n' "$dir" "$(basename "$path")"
}

require_joomla_install() {
	local install_path="$1"

	[[ -n "$install_path" ]] || fail 'JOOMLA_INSTALL is empty'
	[[ "$install_path" != '/' ]] || fail 'JOOMLA_INSTALL must not be /'
	[[ -d "$install_path" ]] || fail "JOOMLA_INSTALL does not exist: $install_path"
	[[ -d "$install_path/administrator" ]] || fail "Not a Joomla install path: $install_path"
}

safe_remove() {
	local path="$1"

	[[ -n "$path" ]] || fail 'Refusing to remove an empty path'
	[[ "$path" != '/' ]] || fail 'Refusing to remove /'
	rm -rf "$path"
}

copy_dir_contents() {
	local source_dir="$1"
	local target_dir="$2"

	[[ -d "$source_dir" ]] || return 0
	mkdir -p "$target_dir"
	cp -a "$source_dir"/. "$target_dir"/
}

copy_file() {
	local source_file="$1"
	local target_file="$2"

	[[ -f "$source_file" ]] || fail "Missing file: $source_file"
	mkdir -p "$(dirname "$target_file")"
	cp "$source_file" "$target_file"
}

copy_file_if_exists() {
	local source_file="$1"
	local target_file="$2"

	[[ -f "$source_file" ]] || return 0
	copy_file "$source_file" "$target_file"
}

make_zip_from_dir() {
	local source_dir="$1"
	local target_file="$2"
	local absolute_target
	local tmp_file

	require_command zip
	[[ -d "$source_dir" ]] || fail "Missing source directory: $source_dir"
	mkdir -p "$(dirname "$target_file")"
	absolute_target="$(absolute_path "$target_file")"
	tmp_file="$absolute_target.tmp"
	rm -f "$tmp_file"
	(cd "$source_dir" && zip -qr "$tmp_file" .)
	mv "$tmp_file" "$absolute_target"
}

make_tar_gz_from_dir() {
	local source_dir="$1"
	local target_file="$2"
	local absolute_target
	local tmp_file

	require_command tar
	[[ -d "$source_dir" ]] || fail "Missing source directory: $source_dir"
	mkdir -p "$(dirname "$target_file")"
	absolute_target="$(absolute_path "$target_file")"
	tmp_file="$absolute_target.tmp"
	rm -f "$tmp_file"
	tar -czf "$tmp_file" -C "$source_dir" .
	mv "$tmp_file" "$absolute_target"
}

version_arg() {
	local passed_version="${1:-}"

	printf '%s\n' "${passed_version:-${VERSION:-latest}}"
}
