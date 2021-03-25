declare -A json_map

while read x y; do
	#printf "$x\n$y\n\n"
	json_map[$x]=$y
done

printf "{\n"
i=1
for key in "${!json_map[@]}"; do
	printf "\t\"$key\": \"${json_map[$key]}\"";
	if [ $i -ne ${#json_map[@]} ] ; then
        printf ",\n"
    fi
    ((i++))
done
printf "\n}\n"

