#!/usr/bin/env php
<?php
require(__DIR__ . '/php_bootstrap.php');

$case_to_fn = array(
	'title' => 'ucwords',
	'lower' => 'strtolower',
	'upper' => 'strtoupper',
);

function tokenize($base, $formats) {
	$matches = array(
		'tokens' => array(),
		'name' => array(),
	);
	$tokens = array();
	echo "Tokenizing $base ...\n";
	foreach ($formats as $f) {
		echo "Using format $f\n";
		$regex = preg_replace('/%[a-z]*/', '(.+)', $f);
		if (preg_match_all('/%([a-z]*)/', $f, $matches['tokens'], PREG_PATTERN_ORDER)) {
		}
		if (preg_match_all("/$regex/", $base, $matches['name'], PREG_PATTERN_ORDER)) {
			echo "Format matched\n";
			break;
		}
		echo "Format failed.\n";
	}
	foreach ($matches['tokens'][1] as $i => $t) {
		if (!empty($matches['name'][$i + 1])) {
			$tokens[$t] = $matches['name'][$i + 1][0];
		}
	}
	echo "Tokens:\n";
	print_r($tokens);
	return $tokens;
}

function get_new_name($tokens, $outformat, $case, $sep) {
	global $case_to_fn;
	$matches = array(
		'tokens' => array(),
	);
	$new_tokens = array();
	$name = $outformat;
	preg_match_all('/%([a-z]*)/', $outformat, $matches['tokens'], PREG_PATTERN_ORDER);
	foreach ($matches['tokens'][1] as $t) {
		echo "Looking for token $t ...\n";
		if (!isset($tokens[$t])) {
			echo "Not found.\n";
			$token = '';
		}
		else {
			$token = $tokens[$t];
			$token = preg_replace('/[\s_]/', $sep, $token);
			$token = call_user_func($case_to_fn[$case], $token);
			echo $tokens[$t].' -> '."$token\n";
		}
		$name = str_replace("%$t", $token, $name);
	}
	return $name;
}

$case = "title";
$sep = " ";
$outformat = "%title";
$informats = array(
	"%artist_-_%album_-_%number_-_%title",
	"%artist_-_%title",
);

$files = array();
exec('/usr/bin/find -type f', $files);

foreach ($files as $f) {
	$base = basename($f);
	$tokens = tokenize($base, $informats);
	if (!empty($tokens)) {
		$name = str_replace($f, get_new_name($tokens, $outformat, $case, $sep), $f);
		echo "$f -> $name\n";
		if (confirm()) {
			rename($f, $name);
		}
	}
}
