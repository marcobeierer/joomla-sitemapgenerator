#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

SOURCE="$REPO_ROOT/pkg_sitemapgenerator/src"
PACKAGES_DIR="$REPO_ROOT/pkg_sitemapgenerator/packages"
EXTENSION="pkg_sitemapgenerator"
COMPONENT_PACKAGE="$REPO_ROOT/com_sitemapgenerator/packages/com_sitemapgenerator-${COMPONENT_VERSION:-latest}.zip"
PACKAGE_COMPONENT_COPY="$SOURCE/packages/com_sitemapgenerator.zip"

usage() {
	cat <<'EOF'
Usage: scripts/build-pkg-sitemapgenerator.sh [package] [version]

Targets:
  package  Build the component ZIP, copy it into the package source, and create
           pkg_sitemapgenerator/packages/pkg_sitemapgenerator-<version>.zip

Environment:
  VERSION            Default package version when [version] is omitted. Defaults to latest.
  COMPONENT_VERSION  Component package version to embed. Defaults to latest.
EOF
}

package_package() {
	local version="$1"
	local target_file="$PACKAGES_DIR/$EXTENSION-$version.zip"

	"$SCRIPT_DIR/build-com-sitemapgenerator.sh" package "${COMPONENT_VERSION:-latest}"
	copy_file "$COMPONENT_PACKAGE" "$PACKAGE_COMPONENT_COPY"
	make_zip_from_dir "$SOURCE" "$target_file"
	printf 'Created %s\n' "$target_file"
}

target="${1:-package}"
case "$target" in
	package)
		package_package "$(version_arg "${2:-}")"
		;;
	-h|--help|help)
		usage
		;;
	*)
		usage >&2
		exit 1
		;;
esac
