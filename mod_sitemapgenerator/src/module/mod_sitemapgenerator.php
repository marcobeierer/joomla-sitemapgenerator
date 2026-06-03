<?php
/*
 * @copyright  Copyright (C) 2015 Marco Beierer. All rights reserved.
 * @license    http://www.gnu.org/licenses/agpl-3.0.html GNU/AGPL
 */

defined('_JEXEC') or die();

use Joomla\CMS\Helper\ModuleHelper;

require ModuleHelper::getLayoutPath('mod_sitemapgenerator', $params->get('layout', 'default'));
