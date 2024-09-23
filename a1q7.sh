read -p "Enter the file name:" file_name

if [ -f "$file_name" ]; then
    echo "File exists."
    read -p "Enter the word to search:" search_word
    word_count=$(grep -o -i -w "$search_word" "$file_name" | wc -l)

    if [ "$word_count" -gt 0 ]; then
        echo "The word '$search_word' occurs $word_count times."
        grep -n -i "$search_word" "$file_name" | while IFS=: read -r line_num line_text; do
            word_occurrences=$(echo "$line_text" | grep -o -i -w "$search_word" | wc -l)
            echo "Line $line_num: $word_occurrences occurrences"
        done
        read -p "Enter the word to replace:" replace_word
        sed -i "s/${search_word}/${replace_word}/gI" "$file_name"
    else
        echo "No occurrences of the word '$search_word' found."
    fi
else
    echo "File does not exist."
fi


