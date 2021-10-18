#! /bin/bash

if [[ -f todo-list.md=true ]] 
	echo "Welcome to your daily dose of organization. Your list has been found. Ready to append..."
then
	until [[ "${answer}" = "no" ]]
	do
		read append
		echo "${append}" >> todo-list.md
		echo "Displaying entries..."
		sleep 1
		nl todo-list.md
		echo "Do you have another entry (yes/no)?"
			read answer
		if [[ "${answer}" != "no" ]]
		then
			echo "Ready to append..."
		fi
	done
fi
