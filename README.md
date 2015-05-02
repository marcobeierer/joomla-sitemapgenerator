# Joomla Sitemap Generator
An easy to use sitemap generator for Joomla.

## How it works
The sitemap generator uses an external service to crawl your website and create a sitemap of your website. The generator works thus for every extension without the need for additional plugins. The computation costs for your website is also very low because the crawler acts like a normal visitor, who visits all pages once.

## Features
- Simple setup.
- Works out of the box with all Joomla extensions.
- Low computations costs for your webserver.
- Uses the Joomla update function.

## Requirements
- Joomla 3.4
- Ajax Interface (delivered with the Joomla core)
- Linux webserver (normally the case)

## Download
The download of the installation package is available at:
https://static.marcobeierer.com/joomla-extensions/sitemapgenerator/pkg_sitemapgenerator-latest.zip

## Installation instructions
1. Download the installation package.
2. Install the package.
3. Go to the "Plugin Manager" and activate the "Ajax - Sitemap Generator" plugin.
4. Go to the "Module Manager", switch to the administrator modules and edit the "Sitemap Generator" module. The following settings are recommended, but you could of course use the settings you prefer.
	- Show Title: Hide
	- Position: status
	- Status: Published
5. Use the "Generate Sitemap" button the create a sitemap. The sitemap will be saved as sitemap.xml in your Joomla root directory. **Be aware that an existing sitemap.xml file would be overwritten without asking.**
6. Access http(s)://www.example.com/sitemap.xml and check if the generated sitemap is complete.

## Is the service free of charge?
Currently yes, but just during the beta phase. Afterwards the service costs about 1 Euro per 500 pages per month. The joomla extensions itself are free of charge, but nearly useless without the external service.

## Limitations
By default the sitemap generator indexes the first 500 pages of your website. If you create a file called *allow-sitemap-generator.html* in your Joomla root directory, the sitemap generator indexes up to 2500 pages. Please contact me if your website is larger. The limitations only apply during the beta phase.

## Warnings
If you already have an existing sitemap.xml in your Joomla root directory, this file would be overwritten. It is thus recommended to backup your existing sitemap.xml file before using the sitemap generator. I also have not tested the generator on Windows webspace. You should also access the sitemap.xml after the generation finished and check if everything is fine.

## Changelog

### 1.0.0-beta.1
- Initial release

### 1.0.0-beta.2
- Fixed update server url

### 1.0.0-beta.3
- Implement delay for subsequent requests
- Added Windows compatibility
