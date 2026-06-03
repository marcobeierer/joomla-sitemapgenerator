#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
	cat <<'EOF'
Usage: scripts/build-all.sh [package] [version]

Builds all installable ZIP/TAR artifacts with bash instead of Phing.

Environment:
  VERSION            Default package version when [version] is omitted. Defaults to latest.
  COMPONENT_VERSION  Component package version embedded by the package build. Defaults to latest.
EOF
}

target="${1:-package}"
version="${2:-${VERSION:-latest}}"

case "$target" in
	package)
		"$SCRIPT_DIR/build-pkg-sitemapgenerator.sh" package "$version"
		"$SCRIPT_DIR/build-mod-sitemapgenerator.sh" package "$version"
		"$SCRIPT_DIR/build-plg-ajax-sitemapgenerator.sh" package "$version"
		;;
	-h|--help|help)
		usage
		;;
	*)
		usage >&2
		exit 1
		;;
esac
