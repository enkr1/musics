#!/bin/bash

# Directory containing audio files (default is current directory)
DIR=${1:-"."}

# Ensure FFmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
  echo "❌ FFmpeg is not installed. Please install it to use this script."
  exit 1
fi

# Function to convert files to WAV
convert_to_wav() {
  local file=$1
  local extension="${file##*.}"
  local filename=$(basename -- "$file")
  local filename_without_ext="${filename%.*}"
  local output="$DIR/$filename_without_ext.wav"

  echo "🎵 Converting: $file -> $output"

  # Convert using FFmpeg
  ffmpeg -i "$file" "$output" -y >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "✅ Conversion successful: $file -> $output"
  else
    echo "❌ Conversion failed: $file"
  fi
}

# Process .aac and .m4a files
for file in "$DIR"/*.aac "$DIR"/*.m4a; do
  if [[ -f "$file" ]]; then
    convert_to_wav "$file"
  fi
done

echo "✅ All conversions completed!"
