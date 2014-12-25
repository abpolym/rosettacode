# To create an array:
alist=( item1 item2 item3 )  # creates a 3 item array called "alist"
declare -a list2        # declare an empty list called "list2"
declare -a list3[0]     # empty list called "list3"; the subscript is ignored

# create a 4 item list, with a specific order
list5=([3]=apple [2]=cherry [1]=banana [0]=strawberry)


# To obtain the number of items in an array:
count=${#alist[*]}
echo "The number of items in alist is ${#alist[*]}"


# To iterate up over the items in the array:
x=0
while [[ $x < ${#alist[*]} ]]; do
	echo "Item $x = ${alist[$x]}"
	: $((x++))
done


# To iterate down over theitems in an array:
x=${#alist[*]}       # start with the number of items in the array
while [[ $x > 0 ]]; do     # while there are items left
	: $((x--))               # decrement first, because indexing is zero-based
	echo "Item $x = ${alist[$x]}"   # show the current item
done


# To append to an array, use the current number of items in the array as the next index:
alist[${#alist[*]}]=new_item


# To make appending easier, use a little shell function, let's call it "push", and design it to allow appending multiple values, while also preserving quoted values:
# shell function to append values to an array
# push LIST VALUES ...
push() {
	local var=${1:?'Missing variable name!'}
	shift
	eval "\$$var=( \"\${$var[@]}\" \"$@\" )"
}
 
push alist "one thing to add"
push alist many words to add


# To delete a single array item, the first item:
unset alist[0]


# To delete and return the last item in an array (e.g., "pop" function):
# pop ARRAY -- pop the last item on ARRAY and output it
 
pop() {
	local var=${1:?'Missing array name'}
	local x ;   eval "x=\${#$var[*]}"
	if [[ $x > 0 ]]; then
		local val ; eval "val=\"\${$var[$((--x))]}\""
		unset $var[$x]
	else
		echo 1>&2 "No items in $var" ; exit 1
	fi
	echo "$val"
}
 
alist=(a b c)
pop alist
# a
pop alist
# b
pop alist
# c
pop alist
# No items in alist


# To delete all the items in an array:
unset alist[*]


# To delete the array itself (and all items in it, of course):
unset alist
