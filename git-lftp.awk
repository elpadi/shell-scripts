#!/usr/bin/awk -f
BEGIN { }
{
	if (index("ADM",$1) == 0) next
	if ($1 == "M") {
		count=split($2, parts, "/")
		printf("put -O %s %s\n", substr($2, 1, length($2) - length(parts[count])), $2)
	}
}
END { }
