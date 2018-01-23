#!/bin/bash

curr=${1:-"1000"}


(( $curr == 1000 )) && unzip -q -o "$curr.zip" || { echo "deu ruim"; exit 1; }


while [ -n "$curr" ]; do
	next=
	commits=$(git --git-dir=./$curr/.git --work-tree=./$curr log --pretty=%H) || exit 1;

	for commit in $commits; do
		git --git-dir=./$curr/.git --work-tree=./$curr checkout $commit . || { echo "deu ruim no checkout"; exit 1; }
		[ "$curr" == "0045" ] && { unzip -q -o -P "fluffy99" "0045/0044.zip" && next=0044; } || {

			for zip in $curr/*.zip; do
				echo $curr
				unzip -q -o -P "incorrect" "$zip" || { echo "done"; exit; }
	
				filename=$(basename "$zip")
				next="${filename%.*}" # without .zip
			done
		}
	done
	

	if [ "$curr" -ne "0001" ]; then
		rm -fr $curr || exit 1;
	fi
	echo $curr - $next
	curr=$next
	
done
