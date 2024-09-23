count_files() {
    local dir="$1"
    local file_count=0

    for item in "$dir"/*; do
        if [[ -f "$item" ]]; then
            file_count=$((file_count+1))
        elif [[ -d "$item" ]]; then
            file_count=$((file_count + $(count_files "$item")))
        fi
    done

    echo "$file_count"
}

count_subdirs() {
    local dir="$1"
    local subdir_count=0

    for item in "$dir"/*; do
        if [[ -d "$item" ]]; then
            subdir_count=$((subdir_count+1))
            subdir_count=$((subdir_count + $(count_subdirs "$item")))
        fi
    done

    echo "$subdir_count"
}

current_dir="."

total_files=$(count_files "$current_dir")
echo "Total number of files: $total_files"

total_subdirs=$(count_subdirs "$current_dir")
echo "Total number of subdirectories: $total_subdirs"