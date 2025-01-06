#!/bin/bash

# File name of the README.md
README_FILE="Logs.md"

# Function to prompt user for input
function prompt_for_input() {
    read -p "$1: " input
    echo "$input"
}

# Collect data from the user
echo "Let's log your learning for the day!"
date=$(prompt_for_input "Enter the date (YYYY-MM-DD)")
topic=$(prompt_for_input "Enter the topic name")
summary=$(prompt_for_input "Enter a brief summary")
blog_url=$(prompt_for_input "Enter the blog URL (if any, else leave blank)")
notes=$(prompt_for_input "Enter the location of your notes (path or repo URL)")
additional_info=$(prompt_for_input "Any additional info you'd like to include")

# Format the new entry
new_entry="| $date | $topic | $summary | [$blog_url]($blog_url) | [$notes]($notes) | $additional_info |"

# Insert the entry into the table in README.md
if grep -q "| Date       |" "$README_FILE"; then
    sed -i "/| Date       |/a $new_entry" "$README_FILE"
else
    echo "Table header not found! Please check your README.md format."
fi

# Append detailed log
cat <<EOL >> "$README_FILE"

---

#### $date - $topic
**Summary**:  
> $summary

**Blog Link**:  
> [$blog_url]($blog_url)

**Notes Location**:  
> [$notes]($notes)

**Additional Info**:  
> $additional_info
EOL

echo "Log added successfully to $README_FILE!"
