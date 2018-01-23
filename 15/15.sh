#!/bin/bash
trynext(){
	numeros=1234567890
	number=$1
	array=( 0 0 0 0 0 0 0 0 0 0 )
	for atual in $(echo $number | sed 's/./\0 /g'); do
		array[$atual]=1
		numeros=$(echo $numeros | tr -d "$atual")
	done

	(( ${#number} < 5 )) && (( ${array[5]} == 1 )) || {
		(( ${#number} < 9 )) && (( ${array[0]} == 1 )) || {
			(( ${#number} == 4 )) && (( ${array[5]} == 0 )) && echo ${number}5 || {
				for guess in $(echo $numeros | sed 's/./\0 /g'); do
					numberguess=$number$guess
					if (( $((10#$numberguess)) % ${#numberguess} == 0 )) && (( ${array[$guess]} == 0 )); then
						echo $numberguess
						array[$guess]=1
					fi
				done
			}
		}
	}
}

main() {
	answ=$(for i in {0..9}; do trynext $i; done)
	steps=1;
	while ! grep -Eo "[0-9]{10}" <<< "$answ"; do
		echo "Step $steps: $(echo "$answ" | wc -w) possibilities"
		answ=$(for i in $answ; do trynext $i; done)
		let steps++
	done
}

main
