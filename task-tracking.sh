#! /bin/bash 

if [[ -f todo-list.md ]]
then
	echo "Ready to append..."
	read append
	echo "${append}" >> todo-list.md
	echo "Displaying entries..."
	sleep 1
	nl todo-list.md
else
	touch todo-list.md
	echo "todo-list.md created. Ready to append..."
	read append
	echo "${append}" >> todo-list.md
	echo "Displaying entries..."
	sleep 1
	nl todo-list.md
fi
