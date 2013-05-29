<?php
function error($s) {
	fwrite(STDERR, $s);
}

function fatal_error($s, $c) {
	error($s);
	exit($c);
}

function confirm() {
	echo "Are you sure [y/n] ?\n";
	return fgetc(STDIN) === 'y';
}

$out = '';

