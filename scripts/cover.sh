#!/bin/bash

id_current=$(cat ~/.conky/conkify/current/current.txt)
id_new=`~/.conky/conkify/scripts/id.sh`
cover=
imgurl=

if [ "$id_new" != "$id_current" ]; then

	cover=`ls ~/.conky/conkify/covers | grep $id_new`

	if [ "$cover" == "" ]; then

	    imgurl=`~/.conky/conkify/scripts/imgurl.sh $id_new`
	    wget -q -O ~/.conky/conkify/covers/$id_new.jpg $imgurl &> /dev/null
		# clean up covers folder, keeping only the latest X amount, in below example it is 10
	    rm -f `ls -t ~/.conky/conkify/covers/* | awk 'NR>10'`
	    rm -f wget-log #wget-logs are accumulated otherwise
	    cover=`ls ~/.conky/conkify/covers | grep $id_new`
	fi

	if [ "$cover" != "" ]; then
		cp ~/.conky/conkify/covers/$cover ~/.conky/conkify/current/current.jpg
	else
		cp ~/.conky/conkify/empty.jpg ~/.conky/conkify/current/current.jpg
	fi

	echo $id_new > ~/.conky/conkify/current/current.txt
fi
