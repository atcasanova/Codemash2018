#!/bin/bash
a=( $(cat a.txt | tr -d '\r\n' | sed 's/./\0 /g') )
b=( $(cat b.txt | tr -d '\r\n' | sed 's/./\0 /g') )
c=( $(cat c.txt | tr -d '\r\n' | sed 's/./\0 /g') )
d=( $(cat d.txt | tr -d '\r\n' | sed 's/./\0 /g') )
lines=$(echo "sqrt(${#a[@]})"|bc )

linha=
start=0
for (( i=0; i<${#a[@]}; i++ )); do
	char=$(( ((~${a[$i]} & ${b[$i]}) | ${c[$i]}) ^ ${d[$i]} ))
	linha+=$char
	(( char == 0 )) \
	&& convert -size 5x5 xc:#ffffff $i.png \
	|| convert -size 5x5 xc:#000000 $i.png

	(( ${#linha} == $lines )) && {
		fim=$(($start+24))
		eval convert +append {$start..$fim}.png out_$i.png
		rm [0-9]*.png
		let start+=25;
		linha=
	}
done
eval convert -append $(ls out_*.png | sort -k2,2 -t"_" -n) qrcode.png
rm -rf out_*.png
zbarimg qrcode.png 2>/dev/null  | head -1 | cut -f2- -d:
rm qrcode.png
