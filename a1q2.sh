read -p "Enter Filename: " file

if [ -f "$file" ]; then
    line=$(wc -l < "$file")
    echo "The file $file has $line lines."
else
    read -p "Enter Message for file: " msg
    echo "Creating $file ..."
    echo "$msg">>"$file"
fi
