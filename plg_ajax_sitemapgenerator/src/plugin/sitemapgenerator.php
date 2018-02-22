<?php
/*
 * @copyright  Copyright (C) 2015 Marco Beierer. All rights reserved.
 * @license    http://www.gnu.org/licenses/agpl-3.0.html GNU/AGPL
 */

defined('_JEXEC') or die();

class plgAjaxSitemapgenerator extends JPlugin {

	public function onAjaxSitemapgenerator() {

		$lang = JFactory::getLanguage();
		$lang->load('plg_ajax_sitemapgenerator');

		$user = JFactory::getUser();
		if (!$user->authorise('core.login.admin')) {
			return JError::raiseError('401', JText::_('PLG_AJAX_SITEMAPGENERATOR_ERROR_NOT_AUTHORISED'));
		}

		$baseurl = JURI::root();
		$baseurl64 = strtr(base64_encode($baseurl), '+/', '-_');

		$subsequentRequest = false; // TODO implement a nicer solution
		do {
			if ($subsequentRequest) {
				usleep(250000); // 250ms
			} else {
				$subsequentRequest = true;
			}

			$ch = curl_init();

			curl_setopt($ch, CURLOPT_URL, 'https://api.marcobeierer.com/sitemap/v2/' . $baseurl64 . '?pdfs=1&joomla=1');
			curl_setopt($ch, CURLOPT_HEADER, 0);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

			$response = curl_exec($ch);

			$statusCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
			$contentType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);

			curl_close($ch);
		}
		while($statusCode == 200 && $contentType != 'application/xml');

		if ($statusCode != 200) {
			return JText::_('PLG_AJAX_SITEMAPGENERATOR_ERROR'); // TODO better error message
		}

		$reader = new XMLReader();
		$reader->xml($response, 'UTF-8');
		$reader->setParserProperty(XMLReader::VALIDATE, true);

		if ($reader->isValid()) { // TODO check if empty?

			if (defined('JPATH_ROOT') && JPATH_ROOT != '') {
				file_put_contents(JPATH_ROOT . DIRECTORY_SEPARATOR . 'sitemap.xml', $response); // TODO handle error
				return JText::_('PLG_AJAX_SITEMAPGENERATOR_SUCCESS');
			}
		}

		return JText::_('PLG_AJAX_SITEMAPGENERATOR_ERROR'); // TODO better error message
	}
}
