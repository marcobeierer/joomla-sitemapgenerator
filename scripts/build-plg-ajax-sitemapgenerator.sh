#!/usr/bin/env bash

set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

SOURCE="$REPO_ROOT/plg_ajax_sitemapgenerator/src"
PACKAGES_DIR="$REPO_ROOT/plg_ajax_sitemapgenerator/packages"
EXTENSION="plg_ajax_sitemapgenerator"
PLUGIN_FOLDER="ajax"
PLUGIN_NAME="sitemapgenerator"
DEFAULT_JOOMLA_INSTALL="/var/www/localhost/htdocs/dev.joomla.test/joomla6"

usage() {
	cat <<'EOF'
Usage: scripts/build-plg-ajax-sitemapgenerator.sh [package|install|clean] [version]

Targets:
  package  Create plg_ajax_sitemapgenerator/packages/plg_ajax_sitemapgenerator-<version>.zip and .tar.gz
  install  Copy the ajax plugin into a Joomla install
  clean    Remove installed plugin files from a Joomla install

Environment:
  VERSION         Default package version when [version] is omitted. Defaults to latest.
  JOOMLA_INSTALL  Joomla root for install/clean. Defaults to /var/www/localhost/htdocs/dev.joomla.test/joomla6.
EOF
}

clean_plugin() {
	local joomla_install="${JOOMLA_INSTALL:-$DEFAULT_JOOMLA_INSTALL}"

	require_joomla_install "$joomla_install"
	safe_remove "$joomla_install/plugins/$PLUGIN_FOLDER/$PLUGIN_NAME"
}

install_plugin() {
	local joomla_install="${JOOMLA_INSTALL:-$DEFAULT_JOOMLA_INSTALL}"

	clean_plugin
	copy_dir_contents "$SOURCE/services" "$joomla_install/plugins/$PLUGIN_FOLDER/$PLUGIN_NAME/services"
	copy_dir_contents "$SOURCE/src" "$joomla_install/plugins/$PLUGIN_FOLDER/$PLUGIN_NAME/src"
	copy_file "$SOURCE/$PLUGIN_NAME.xml" "$joomla_install/plugins/$PLUGIN_FOLDER/$PLUGIN_NAME/$PLUGIN_NAME.xml"
	copy_file_if_exists "$SOURCE/language/en-GB.$EXTENSION.ini" "$joomla_install/administrator/language/en-GB/en-GB.$EXTENSION.ini"
	copy_file_if_exists "$SOURCE/language/en-GB.$EXTENSION.sys.ini" "$joomla_install/administrator/language/en-GB/en-GB.$EXTENSION.sys.ini"
	printf 'Installed %s into %s\n' "$EXTENSION" "$joomla_install"
}

package_plugin() {
	local version="$1"
	local zip_file="$PACKAGES_DIR/$EXTENSION-$version.zip"
	local tar_file="$PACKAGES_DIR/$EXTENSION-$version.tar.gz"

	make_zip_from_dir "$SOURCE" "$zip_file"
	make_tar_gz_from_dir "$SOURCE" "$tar_file"
	printf 'Created %s\n' "$zip_file"
	printf 'Created %s\n' "$tar_file"
}

target="${1:-package}"
case "$target" in
	package)
		package_plugin "$(version_arg "${2:-}")"
		;;
	install)
		install_plugin
		;;
	clean)
		clean_plugin
		;;
	-h|--help|help)
		usage
		;;
	*)
		usage >&2
		exit 1
		;;
esac
