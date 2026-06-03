<?php
/*
 * @copyright  Copyright (C) 2015 - 2026 Marco Beierer. All rights reserved.
 * @license    http://www.gnu.org/licenses/agpl-3.0.html GNU/AGPL
 */

defined('_JEXEC') or die;

use Joomla\CMS\Extension\PluginInterface;
use Joomla\CMS\Factory;
use Joomla\CMS\Plugin\PluginHelper;
use Joomla\DI\Container;
use Joomla\DI\ServiceProviderInterface;
use MarcoBeierer\Plugin\Ajax\SitemapGenerator\Extension\SitemapGenerator;

return new class implements ServiceProviderInterface {
	public function register(Container $container): void
	{
		$container->set(
			PluginInterface::class,
			$container->lazy(SitemapGenerator::class, function (Container $container) {
				$config = (array) PluginHelper::getPlugin('ajax', 'sitemapgenerator');
				$plugin = new SitemapGenerator($config);
				$plugin->setApplication(Factory::getApplication());

				return $plugin;
			})
		);
	}
};
