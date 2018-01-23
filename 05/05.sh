#!/bin/bash
a=( $(cat a.txt | tr -d '\r\n' | sed 's/./\0 /g') )
b=( $(cat b.txt | tr -d '\r\n' | sed 's/./\0 /g') )
c=( $(cat c.txt | tr -d '\r\n' | sed 's/./\0 /g') )
d=( $(cat d.txt | tr -d '\r\n' | sed 's/./\0 /g') )

totallines=$(echo "sqrt(${#a[@]})"|bc )
size=$((totallines*2))
comando="convert -size ${size}x${size} xc:none"
line=
col=0
linha=0
for (( i=0; i<${#a[@]}; i++ )); do
	char=$(( ((~${a[$i]} & ${b[$i]}) | ${c[$i]}) ^ ${d[$i]} ))
	line+=$char
	(( char == 0 )) \
		&& comando+=" -fill white -draw \"rectangle $col,$linha $(($col+2)),$(($linha+2))\"" \
		|| comando+=" -fill black -draw \"rectangle $col,$linha $(($col+2)),$(($linha+2))\""
	let col+=2

	(( ${#line} == $totallines )) && {
		let linha+=2
		col=0
		line=
	}
done

echo $comando qrcode$$.png > tmp$$
chmod +x tmp$$
./tmp$$
zbarimg qrcode$$.png 2>/dev/null | cut -f2 -d:
rm qrcode$$.png tmp$$
