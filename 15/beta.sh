#!/bin/bash
trynext(){
	numeros=1234567890
	number=$1
	array=( 0 0 0 0 0 0 0 0 0 0 )
	(( ${#number} < 10 )) && { array[0]=1; numeros=123456789; }
	(( ${#number} < 5 )) && { array[5]=1; numeros=12346789; }

	for atual in $(echo $number | sed 's/./\0 /g'); do
		array[$atual]=1
		numeros=$(echo $numeros | tr -d "$atual")
	done

	for guess in $(echo $numeros | sed 's/./\0 /g'); do
		numberguess=$number$guess
		if (( $((10#$numberguess)) % ${#numberguess} == 0 )) && (( ${array[$guess]} == 0 )); then
			case ${#numberguess} in
				4) echo ${numberguess}5;;
				9) echo ${numberguess}0;;
				*) echo ${numberguess};;
			esac
		fi
	done
}	

main() {
	answ=$(for i in {1..4} {6..9}; do trynext $i; done)
	steps=1;
	while ! grep -Eo "[0-9]{10}" <<< "$answ"; do
		echo "Step $steps: $(echo "$answ" | wc -w) possibilities"
		answ=$(for i in $answ; do trynext $i; done)
		let steps++
	done
}

main
