#!/bin/bash

# File containing the list of URLs
URL_FILE="url_value.txt"

# Base directory that already exists
#  BASE_DIR="sipp-be-files"

# Log file for recording download activities
LOG_FILE="download.log"
SECONDS=0
STARTTIME=$(date +"%a %d %b %Y %H:%M:%S WIB")
# Clear or create the log file at the start
echo "START Download Log - $STARTTIME" > "$LOG_FILE"
echo "=========================" >> "$LOG_FILE"

download_file(){
    retrying=$1
    counter= $2
    encoded_url= $3
    if wget -q --show-progress -O "$full_file_path" "$encoded_url"; then
      echo "$counter. Downloaded: $full_file_path" | tee -a "$LOG_FILE"
    else
      sleep 5
      retrying_download $retrying $counter $encoded_url
    fi
}

retrying_download(){
    retrying=$1
    counter= $2
    encoded_url= $3
    if [[ $retrying -ge 3 ]] then
      echo "$counter. Failed to download after 3 attemp: $encoded_url" | tee -a "$LOG_FILE"
    else
      echo "$counter. retry $1 to download: $encoded_url" | tee -a "$LOG_FILE"
      retrying=$((retrying + 1))
      download_file $retrying $counter $encoded_url
    fi
}

# Initialize a counter for numbering the log entries
counter=1

# Read each URL from the file
while IFS= read -r url; do
  # Replace spaces with %20 for URL encoding
  encoded_url=$(echo "$url" | sed 's/ /%20/g')
  
  # Extract the file path from the URL (remove leading "/")
  file_path=$(echo "$url" | cut -d'/' -f4-)
  
  # Extract the directory path and file name from the file path
  directory_path=$(dirname "$file_path")
  file_name=$(basename "$file_path")
  
  # Create the full local directory path
  full_directory_path="$directory_path"
  
  # Create the directory if it doesn't exist
  mkdir -p "$full_directory_path"
  
  # Full local path for the file
  full_file_path="$full_directory_path/$file_name"

    # Download the file using wget
    download_file 0 $counter $encoded_url

  # Increment the counter
  counter=$((counter + 1))

done < "$URL_FILE"

ENDTIME=$(date +"%a %d %b %Y %H:%M:%S WIB")

echo "=========================" >> "$LOG_FILE"
echo "FINISH Download Log - $ENDTIME" >> "$LOG_FILE"

duration=$SECONDS
echo "Elapsed Time (using \$SECONDS): $SECONDS seconds"  >> "$LOG_FILE"
echo "$((duration / 60)) minutes and $((duration % 60)) seconds elapsed."  >> "$LOG_FILE"
echo "$((duration / 3600)) Hours elapsed." >> "$LOG_FILE"

