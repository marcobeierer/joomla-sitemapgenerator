# Joomla Sitemap Generator
An easy to use sitemap generator for Joomla. Detailed information is available on my website:

[Joomla Sitemap Generator](https://www.marcobeierer.com/joomla-extensions/sitemap-generator)

## Changelog
The versions in the changelog refer to the version numbers of the Sitemap Generator package.

### 1.4.1
*Release date: 1st August 2022*

- Added payment info.

### 1.4.0
*Release date: 21th October 2019*

- Features
	- Completely rewritten user interface.
		- Uniform on all platforms (WordPress, online tool, WebsiteTools and Joomla).
	- Sitemap backup on Sitemap Generator servers (pro only).
	- Download function to redownload sitemap from last run (pro only).
	- Stop generation process.
	- Show more detailed stats after generation has finished.
- Usability
	- Autoresume without an extra click when already running.
	- Load stats of last generation process when Sitemap Generator is opened (pro only).
	- Added tabs for multilang sites for a better overview.
- Config
	- Set default value for `Reference Count Threshold` to 5 for new and old installations.
	- Set default value for `Max Fetchers` to 3 for old installations.

### 1.3.0
*Release date: 23th November 2018*

- Added option to disable cookies.
- Added option to remove query parameters from URLs before they are added to the sitemap.
- Added reference count threshold option to ignore for example images if they are embedded on more than x pages.
- Removed CA Fallback option.

### 1.2.1
*Release date: 14th April 2018*

- Force the use of IPv4, because IPv6 does not work for all configurations, probably due to a bug in some curl versions or the PHP curl integration.
- Multiple crawler improvements.
	- Added cookie support.

### 1.2.0
*Release date: 31th May 2016*

- Implemented Cache-Control for ajax requests.
- Fixed memory issue with very large sitemaps.
- Added option to ignore embedded content (for example images).
- Added option to select the maximum number of concurrent connections.
- Discontinued development of Sitemap Generator module and plugin and implemented an uninstall notice.

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
