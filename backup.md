Current_time="$(date +%d-%b) @ $(date +%H:%M)"
			echo ""
			echo "Ready to append..."
			echo ""
			echo "Input ↓↓↓"
			read append
			echo ""
			echo "${append} | created on "${Current_time}"" >> "${FILE}"
			echo "${append} | created on "${Current_time}"" >> "${FILE1}"
			echo "Entry added on "${Current_time}""
			display
