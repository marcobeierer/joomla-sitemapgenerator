#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

SOURCE="$REPO_ROOT/mod_sitemapgenerator/src"
PACKAGES_DIR="$REPO_ROOT/mod_sitemapgenerator/packages"
MODULE_NAME="mod_sitemapgenerator"
DEFAULT_JOOMLA_INSTALL="/var/www/localhost/htdocs/dev.joomla.test/joomla6"

usage() {
	cat <<'EOF'
Usage: scripts/build-mod-sitemapgenerator.sh [package|install|clean] [version]

Targets:
  package  Create mod_sitemapgenerator/packages/mod_sitemapgenerator-<version>.zip
  install  Copy the administrator module into a Joomla install
  clean    Remove installed module files from a Joomla install

Environment:
  VERSION         Default package version when [version] is omitted. Defaults to latest.
  JOOMLA_INSTALL  Joomla root for install/clean. Defaults to /var/www/localhost/htdocs/dev.joomla.test/joomla6.
EOF
}

clean_module() {
	local joomla_install="${JOOMLA_INSTALL:-$DEFAULT_JOOMLA_INSTALL}"

	require_joomla_install "$joomla_install"
	safe_remove "$joomla_install/administrator/modules/$MODULE_NAME"
	safe_remove "$joomla_install/media/$MODULE_NAME"
}

install_module() {
	local joomla_install="${JOOMLA_INSTALL:-$DEFAULT_JOOMLA_INSTALL}"

	clean_module
	copy_dir_contents "$SOURCE/module" "$joomla_install/administrator/modules/$MODULE_NAME"
	copy_file "$SOURCE/$MODULE_NAME.xml" "$joomla_install/administrator/modules/$MODULE_NAME/$MODULE_NAME.xml"
	copy_dir_contents "$SOURCE/media" "$joomla_install/media/$MODULE_NAME"
	copy_file_if_exists "$SOURCE/language/en-GB.$MODULE_NAME.ini" "$joomla_install/administrator/language/en-GB/en-GB.$MODULE_NAME.ini"
	copy_file_if_exists "$SOURCE/language/en-GB.$MODULE_NAME.sys.ini" "$joomla_install/administrator/language/en-GB/en-GB.$MODULE_NAME.sys.ini"
	printf 'Installed %s into %s\n' "$MODULE_NAME" "$joomla_install"
}

package_module() {
	local version="$1"
	local target_file="$PACKAGES_DIR/$MODULE_NAME-$version.zip"

	make_zip_from_dir "$SOURCE" "$target_file"
	printf 'Created %s\n' "$target_file"
}

target="${1:-package}"
case "$target" in
	package)
		package_module "$(version_arg "${2:-}")"
		;;
	install)
		install_module
		;;
	clean)
		clean_module
		;;
	-h|--help|help)
		usage
		;;
	*)
		usage >&2
		exit 1
		;;
esac
