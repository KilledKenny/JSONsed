#!/bin/sh



sed -e '


:a #Used after each prosseced token




s/^[ \t\r\n]\+//#Cleen




#All one charactes expept . 
/^\([,:{}]\|\]\|\[\)/{
	#Pre Flusher
	/^\]\|^}\|^{/{
	x
	/[^ ]/{
		p

		s/\( *\)\(.*\)/\1/
	}
	x
	}

	#Append Last char. May contain prev data
	#May contain trailing
	H
	x
	/^\n/ {s/\(.\)\(.\)\(.*\)/\2/}
	/^\n/!{s/\([^\n]*\)\(\n*\)\(.\)\(.*\)/\1\3/}
	s/\n//g
	x



	#Subing
	/^\]\|^}/{
		x
		s/^    //
		x
	}





	#Post flushers
	/^,\|^\[\|^\]\|^}\|^{/{
		x
		p
		s/\( *\)\(.*\)/\1/

		x
	}
	#s/\n//



	#Adding or removing line

	#Adding
	/^\[\|^{/{
		x
		s/^/    /
		x
	}


	s/.//
	ba
}


#New String extractor
/^"/{H
	x
	s/\([^\n]*\)\(\n\)\("\(\([^"]\)\|\(\\.\)\)*"\)\(.*\)/\1\o033[95m\3\o033[0m/
	x
	s/"\(\([^"]\)\|\(\\.\)\)*"//
	ba
}


/^[0-9-]/{H
	x
	s/\([^\n]*\)\(\n\)\(-\?[0-9]\+\(.[0-9]\+\)\?\([eE]\([+-]\?\)\?[0-9]\+\)\?\)\(.*\)/\1\o033[95m\3\o033[0m/
	x
	s/^\(-\?[0-9]\+\(.[0-9]\+\)\?\([eE]\([+-]\?\)\?[0-9]\+\)\?\)\+//
	ba
}

/^true\|^false\|^null/{H
	x
	s/\([^\n]*\)\(\n\)\(true\|false\|null\+\)\(.*\)/\1\o033[96m\3\o033[0m/
	x
	s/^true\|^false\|^null//
	ba
}

${p}
d'







