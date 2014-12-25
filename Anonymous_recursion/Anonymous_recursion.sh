fib() {
	if test 0 -gt "$1"; then
		echo "fib: fib of negative" 1>&2
		return 1
	else
		(
			fib2() {
				if test 2 -gt "$1"; then
					echo "$1"
				else
					echo $(( $(fib2 $(($1 - 1)) ) + $(fib2 $(($1 - 2)) ) ))
				fi
			}
			fib2 "$1"
		)
	fi
}

for i in -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12; do
	fib $i
done
