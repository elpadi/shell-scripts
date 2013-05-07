<?php
function error($s) {
	fwrite(STDERR, $s);
}

function fatal_error($s, $c) {
	error($s);
	exit($c);
}

$out = '';

