# Create github markdown table for TLS results
# gawk -f mktable.awk mkr1010.txt esp32.txt esp8266_bearssl.txt  esp8266_axtls.txt >table.md
BEGIN {
	OFS="|";
	print "Board", "TLS Version", "Rating", "Ephemeral keys supported", \
		  "Session ticket supported", "TLS compression supported", \
		  "Unknown cipher suite supported", "Beast vuln", \
		  "Able to detect n minus one splitting"
	print "---", "---", "---", "---", "---", "---", "---", "---", "---"
}

/^TLS protocol:/ {
	if (filename == "") filename = FILENAME;
	if (filename != "" && filename != FILENAME) {
		if (proto != "") {
			sub(/\.txt$/, "", filename);
			print filename, proto, rating, eph, sess, comp, unk, beast, nminus1;
		}
		filename = FILENAME;
	}
	proto = rightside($0);
	rating = "";
	eph = "";
	sess = "";
	comp = "";
	unk = "";
	beast = "";
	nminus1 = "";
	next;
}

/^Rating:/ {
	rating = rightside($0);
	next;
}

/^Ephemeral keys supported:/ {
	eph = rightside($0);
	next;
}


/^Session ticket supported/ {
	sess = rightside($0);
	next;
}

/^TLS compression supported:/ {
	comp = rightside($0);
	next;
}

/^Unknown cipher suite supported/ {
	unk = rightside($0);
	next;
}

/^Beast vuln:/ {
	beast = rightside($0);
	next;
}

/^Able to detect n minus one splitting:/ {
	nminus1 = rightside($0);
	next;
}

END {
	if (proto != "") {
		sub(/\.txt$/, "", filename);
		print filename, proto, rating, eph, sess, comp, unk, beast, nminus1;
	}
}

# s is a string like this "a b c: d e f". Return the 
# substring to the right of the colon.
function rightside(s,	fields) {
	split(s, fields, ":");
	return fields[2];
}
