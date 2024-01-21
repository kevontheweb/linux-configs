#!/usr/bin/env fish

# Define the file to store the last execution date
set last_execution_file /tmp/.last_motd_execution

# Check if the script has already been executed today
if test -e $last_execution_file
    set last_execution_date (cat $last_execution_file)
    set today (date +%Y-%m-%d)

    if test "$last_execution_date" = "$today"
        # Exit without running the script if already executed today
        exit
    end
end

# Get the day of the week in lowercase
set day (date +%A | tr '[:upper:]' '[:lower:]')

# Display the relevant image based on the day of the week in lowercase
cat ~/.config/fish/motd_images/$day.png | convert - -colors 16 -geometry 50% sixel:-

# Print a newline to avoid overwriting the last line of the image
echo

# Display date, time
echo "Date: "(date)
echo "Time: "(date +%T)

# Display system properties
echo "Memory Usage: "(free -m | awk '/Mem/ {printf "%.2f%", $3/$2 * 100}')
echo "CPU Load: "(uptime | awk '{print $10 " " $11 " " $12}')
echo "Disk Space Usage: "(df -h | awk '$NF=="/" {printf "%s", $5}')

# Save the current date as the last execution date
echo $today > $last_execution_file
