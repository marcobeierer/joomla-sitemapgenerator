<?php
/*
 * @copyright  Copyright (C) 2015 Marco Beierer. All rights reserved.
 * @license    http://www.gnu.org/licenses/agpl-3.0.html GNU/AGPL
 */

defined('_JEXEC') or die();

JHtml::_('behavior.modal');
?>

<a class="modal btn btn-small" href="<?php echo JRoute::_('index.php?option=com_ajax&plugin=sitemapgenerator&format=raw'); ?>" rel="{size: {x:400, y:100}}"><?php echo JText::_('MOD_SITEMAPGENERATOR_GENERATE_SITEMAP'); ?></a>
