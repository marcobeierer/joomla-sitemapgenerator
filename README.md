# Joomla Sitemap Generator
An easy to use sitemap generator for Joomla. Detailed information is available on my website:

[Joomla Sitemap Generator](https://www.marcobeierer.com/joomla-extensions/sitemap-generator)

## Changelog
The versions in the changelog refer to the version numbers of the Sitemap Generator package.

### 1.1.0-rc.1
*Release date: 14th February 2016*

* Improved support for mutlilanguage sites.
* Support for cURL CA fallback file.

### 1.0.0-rc.2
*Release date: 17th November 2015*

* Better error messages for cURL errors.

### 1.0.0-rc.1
*Release date: 11th November 2015*

* Implemented crawl and sitemap stats.
* Implemented error message if backend is down.
* Implemented better error messages to detect problems on startup.
* Implemented better error message if token is invalid or has expired.
* Implemented better error message if limit is reached.
* Better error reporting if website is not reachable.
* Fixed bug that files from external websites (for example pdf files) were added to the sitemap.
* Added a check for the correct cURL version.
* Added a check if the plugin is used in a local development environment.
* Technical changes
	* Renamed global JS vars (namespacing).
	* Removed german language strings.
	* Moved some vars to a separate file to use the same JS file with multiple CMS.

### 1.0.0-beta.5
- Added a component for the sitemap generation.

### 1.0.0-beta.4
- Added permission check to plugin.
- Fixed uninstall bug.

### 1.0.0-beta.3
- Implement delay for subsequent requests.
- Added Windows compatibility.

### 1.0.0-beta.2
- Fixed update server url.

### 1.0.0-beta.1
- Initial release.
