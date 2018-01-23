mask=22222222222222222222
palpite=
ans=0
while (( ${#palpite} < 20 )); do
	for i in {0..9}; do
		guess=$palpite$i
		guess=${guess}${mask:${#guess}}
		answ=$(echo ${guess} | nc codemash.hacking-lab.com 8357 | tail -1 | grep -Eo "[0-9]+" | tr -d '\n')
		[ "$answ" != "$ans" ] && {
			ans=$answ
			palpite=${guess:0:${answ}}
			echo "$palpite correto (size: ${#palpite})"
			break;
		}
	done
done
echo $palpite | nc codemash.hacking-lab.com 8357