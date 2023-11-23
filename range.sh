#!/bin/zsh
for j1 in {1..1}
do
	for j2 in {1..1}
	do
		s=$(docker exec -it 39c462176253 ./t.sh 99 99 $j1 $j2)
   		printf "%s\n" "$s"
        printf "%s," "$s"
        printf "\n"
 	done
done
