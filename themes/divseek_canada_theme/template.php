<?php

/**
 * @file
 * The primary PHP file for this theme.
 */


function divseek_theme_registry_alter(&$registry) {
  // Re-run Menu View's theme registry alters.
  if (function_exists('menu_views_theme_registry_alter')) {
    menu_views_theme_registry_alter($registry);
  }
}