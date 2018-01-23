#!/bin/bash
a=( $(cat a.txt | tr -d '\r\n' | sed 's/./\0 /g') )
b=( $(cat b.txt | tr -d '\r\n' | sed 's/./\0 /g') )
c=( $(cat c.txt | tr -d '\r\n' | sed 's/./\0 /g') )
d=( $(cat d.txt | tr -d '\r\n' | sed 's/./\0 /g') )

line=
for (( i=0; i<${#a[@]}; i++ )); do
	char=$(( ((~${a[$i]} & ${b[$i]}) | ${c[$i]}) ^ ${d[$i]} ))
	line+=$char
done

binary2qrcode(){
	totallines=$(echo "sqrt(${#1})"|bc )
	size=$((totallines*2))
	comando="convert -size ${size}x${size} xc:none"
	col=0
	linha=0
	while read -n1 char; do
		(( char == 0 )) \
			&& comando+=" -fill white -draw \"rectangle $col,$linha $(($col+2)),$(($linha+2))\"" \
			|| comando+=" -fill black -draw \"rectangle $col,$linha $(($col+2)),$(($linha+2))\""
		let col+=2
	
		(( $col == $size )) && {
			let linha+=2
			col=0
		}
	done <<< $1

	echo $comando qrcode$$.png > tmp$$
	chmod +x tmp$$
	./tmp$$
	zbarimg qrcode$$.png 2>/dev/null | cut -f2 -d:
	rm qrcode$$.png tmp$$
}

binary2qrcode $line
