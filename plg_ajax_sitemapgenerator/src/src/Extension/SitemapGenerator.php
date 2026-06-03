<?php
/*
 * @copyright  Copyright (C) 2015 - 2026 Marco Beierer. All rights reserved.
 * @license    http://www.gnu.org/licenses/agpl-3.0.html GNU/AGPL
 */

namespace MarcoBeierer\Plugin\Ajax\SitemapGenerator\Extension;

defined('_JEXEC') or die;

use Joomla\CMS\Event\Plugin\AjaxEvent;
use Joomla\CMS\Language\Text;
use Joomla\CMS\Plugin\CMSPlugin;
use Joomla\CMS\Uri\Uri;
use Joomla\Event\SubscriberInterface;

final class SitemapGenerator extends CMSPlugin implements SubscriberInterface
{
	protected $autoloadLanguage = true;

	public static function getSubscribedEvents(): array
	{
		return [
			'onAjaxSitemapgenerator' => 'onAjaxSitemapgenerator',
		];
	}

	public function onAjaxSitemapgenerator(AjaxEvent $event): void
	{
		if (!$this->getApplication()->getIdentity()->authorise('core.login.admin')) {
			throw new \RuntimeException(Text::_('PLG_AJAX_SITEMAPGENERATOR_ERROR_NOT_AUTHORISED'), 401);
		}

		$event->addResult($this->generateSitemap());
	}

	private function generateSitemap(): string
	{
		$baseurl = Uri::root();
		$baseurl64 = strtr(base64_encode($baseurl), '+/', '-_');
		$response = '';
		$statusCode = 0;
		$contentType = '';
		$subsequentRequest = false;

		do {
			if ($subsequentRequest) {
				usleep(250000);
			} else {
				$subsequentRequest = true;
			}

			$ch = curl_init();

			curl_setopt($ch, CURLOPT_URL, 'https://api.marcobeierer.com/sitemap/v2/' . $baseurl64 . '?pdfs=1&joomla=1');
			curl_setopt($ch, CURLOPT_HEADER, 0);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

			$response = curl_exec($ch);
			$statusCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
			$contentType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE) ?: '';

			curl_close($ch);
		} while ($statusCode == 200 && stripos($contentType, 'application/xml') !== 0);

		if ($response === false || $statusCode != 200) {
			return Text::_('PLG_AJAX_SITEMAPGENERATOR_ERROR');
		}

		$reader = new \XMLReader();
		$reader->xml($response, 'UTF-8');
		$reader->setParserProperty(\XMLReader::VALIDATE, true);

		if ($reader->isValid() && defined('JPATH_ROOT') && JPATH_ROOT != '') {
			file_put_contents(JPATH_ROOT . DIRECTORY_SEPARATOR . 'sitemap.xml', $response);

			return Text::_('PLG_AJAX_SITEMAPGENERATOR_SUCCESS');
		}

		return Text::_('PLG_AJAX_SITEMAPGENERATOR_ERROR');
	}
}
