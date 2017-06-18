#!/usr/bin/awk -f

function fileUpload(path) {
	count=split(path, parts, "/")
	printf("put -O %s %s\n", substr(path, 1, length(path) - length(parts[count])), path)
}

function dirUpload(path) {
	count=split(path, parts, "/")
	printf("mirror -x '.git' -x 'test' -x 'docs' -R %s %s", path, path)
}

BEGIN { }
{
	TEST=0 
	if (TEST) {
		print ($1 "----" $2)
		next
	}
	
	# Ignore lines that are not about the files
	if (index("??-M-D", $1) == 0) next
	
	if ($1 == "M") {
		fileUpload($2)
	}
	if ($1 == "??" && system("[ ! -d " $2 " ]") == 0) {
		fileUpload($2)
	}
	if ($1 == "??" && system("[ -d " $2 " ]") == 0) {
		dirUpload($2)
	}
}
END { }
