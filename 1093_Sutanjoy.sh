#!/bin/bash
LOGFILE="logfile.txt"
DELETED_DIR="deleted-files"

mkdir -p "$DELETED_DIR"

greet_user() {
    local user_name
    user_name=$(whoami)
    local current_hour
    current_hour=$(date +%H)

    if [ "$current_hour" -lt 12 ]; then
        echo "Hello $user_name, good morning"
    else
        echo "Hello $user_name, good evening"
    fi

    log_action "Display greetings"
}


list_large_files() {
    echo -n "Enter size in bytes: "
    read size
    echo "Files greater than or equal to $size bytes:"
    
    find . -type f -size +"$size"c -exec du -h {} + | awk '{print $2 ": " $1}' || echo "No files found."

    log_action "List large files"
}



disk_usage() {
    echo "Disk usage:"
    df -h

    log_action "Disk usage"
}


view_log_file() {
    echo "Log file contents:"
    if [ -f "$LOGFILE" ]; then
        cat "$LOGFILE"
    else
        echo "Log file does not exist."
    fi

    log_action "View log file"
}


read_existing_file() {
    echo -n "Enter the filename to read: "
    read filename
    if [ -f "$filename" ]; then
        cat "$filename"
    else
        echo "File does not exist."
    fi

    log_action "Read an existing file"
}


remove_file() {
    if [ "$1" == "-c" ]; then
        clear_deleted_files
        return
    fi

    filename="$1"

    if [ -f "$filename" ]; then
        base_name=$(basename "$filename")
        version=0
        
        while [ -e "$DELETED_DIR/$base_name-v$version" ]; do
            version=$((version + 1))
        done
        
        mv "$filename" "$DELETED_DIR/$base_name-v$version"
        echo "$filename moved to $DELETED_DIR/$base_name-v$version"
        log_action "Removed file: $filename"
    else
        echo "File does not exist."
    fi
}

clear_deleted_files() {
    echo -n "Are you sure you want to clear the deleted-files directory? (y/n): "
    read confirmation

    if [ "$confirmation" == "y" ]; then
        rm -r "$DELETED_DIR"/*
        echo "Deleted-files directory cleared."
    else
        echo "Clearing aborted."
    fi
}


log_action() {
    local action="$1"
    local user_name
    user_name=$(whoami)
    echo "$user_name % $action % $(date)" >> "$LOGFILE"
}

remove_action(){   
    echo -n "Enter command (rm <filename> or rm -c to clear): "
            read -a command  # Use -a to read into an array

            if [ "${command[0]}" == "rm" ]; then
                if [ "${#command[@]}" -eq 2 ]; then
                    if [ "${command[1]}" == "-c" ]; then
                        remove_file -c  
                    else
                        remove_file "${command[1]}"  
                    fi
                elif [ "${#command[@]}" -eq 1 ]; then
                    echo "Error: Invalid command format. Use 'rm <filename>' or 'rm -c' to clear."
                else
                    echo "Error: Too many arguments. Use 'rm <filename>' or 'rm -c' to clear."
                fi
             fi   
}


while true; do
    echo "[1] Display greetings"
    echo "[2] List large files"
    echo "[3] Disk usage"
    echo "[4] View Log File"
    echo "[5] Read an existing file"
    echo "[6] Remove an existing file"
    echo "[7] Exit"
    echo -n "Your choice > "
    read choice

    case $choice in
        1) greet_user ;;
        2) list_large_files ;;
        3) disk_usage ;;
        4) view_log_file ;;
        5) read_existing_file ;;
        6)remove_action ;;
        7) exit 0 ;;
        *) echo "Error: Invalid option. Please choose a number between 1 and 7." ;;
    esac
done