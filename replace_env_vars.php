#!/usr/bin/env php
<?php
chdir(__DIR__);
require('./php_bootstrap.php');

function replace_env_vars($s) {
	return preg_replace_callback('/\$([A-Z_]*)/', function($matches) {
		if (empty($matches[1])) {
			return '';
		}
		if (!isset($_ENV[$matches[1]])) {
			fatal_error("Variable $matches[1] not found.", 1);
		}
		return $_ENV[$matches[1]];
	}, $s);
}

$vars = array();
exec('cat ~/.env_vars | grep = | sed "s/export //"', $vars);
foreach ($vars as $var) {
	$var = explode('=', $var);
	$_ENV[$var[0]] = str_replace('"', '', $var[0] === 'PATH' ? $var[1] : replace_env_vars($var[1]));
}

while ($l = fgets(STDIN)) {
	$out .= replace_env_vars($l);
}
fwrite(STDOUT, $out);
