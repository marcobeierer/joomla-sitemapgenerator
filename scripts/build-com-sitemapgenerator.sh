#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

SOURCE="$REPO_ROOT/com_sitemapgenerator/src"
PACKAGES_DIR="$REPO_ROOT/com_sitemapgenerator/packages"
EXTENSION="com_sitemapgenerator"
EXTENSION_XML="sitemapgenerator.xml"
DEFAULT_JOOMLA_INSTALL="$REPO_ROOT/../../../dev.joomla.test/joomla6"

usage() {
	cat <<'EOF'
Usage: scripts/build-com-sitemapgenerator.sh [package|install|clean] [version]

Targets:
  package  Create com_sitemapgenerator/packages/com_sitemapgenerator-<version>.zip
  install  Copy the component into a Joomla install
  clean    Remove installed component files from a Joomla install

Environment:
  VERSION         Default package version when [version] is omitted. Defaults to latest.
  JOOMLA_INSTALL  Joomla root for install/clean. Defaults to ../../../dev.joomla.test/joomla6.
EOF
}

clean_component() {
	local joomla_install="${JOOMLA_INSTALL:-$DEFAULT_JOOMLA_INSTALL}"

	require_joomla_install "$joomla_install"
	safe_remove "$joomla_install/components/$EXTENSION"
	safe_remove "$joomla_install/administrator/components/$EXTENSION"
	safe_remove "$joomla_install/media/$EXTENSION"
}

install_component() {
	local joomla_install="${JOOMLA_INSTALL:-$DEFAULT_JOOMLA_INSTALL}"

	clean_component
	copy_dir_contents "$SOURCE/backend" "$joomla_install/administrator/components/$EXTENSION"
	copy_file "$SOURCE/$EXTENSION_XML" "$joomla_install/administrator/components/$EXTENSION/$EXTENSION_XML"
	copy_dir_contents "$SOURCE/language/backend" "$joomla_install/administrator/language"
	copy_dir_contents "$SOURCE/media" "$joomla_install/media/$EXTENSION"
	printf 'Installed %s into %s\n' "$EXTENSION" "$joomla_install"
}

package_component() {
	local version="$1"
	local target_file="$PACKAGES_DIR/$EXTENSION-$version.zip"

	make_zip_from_dir "$SOURCE" "$target_file"
	printf 'Created %s\n' "$target_file"
}

target="${1:-package}"
case "$target" in
	package)
		package_component "$(version_arg "${2:-}")"
		;;
	install)
		install_component
		;;
	clean)
		clean_component
		;;
	-h|--help|help)
		usage
		;;
	*)
		usage >&2
		exit 1
		;;
esac
