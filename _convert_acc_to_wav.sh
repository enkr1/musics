#!/bin/bash

# Directory containing AAC files (default is current directory)
DIR=${1:-"."}

# Ensure FFmpeg is installed
if ! command -v ffmpeg &>/dev/null; then
  echo "❌ FFmpeg is not installed. Please install it to use this script."
  exit 1
fi

# Find and convert each .aac file to .wav
for file in "$DIR"/*.aac; do
  if [[ -f "$file" ]]; then
    # Get the filename without the extension
    filename=$(basename -- "$file")
    filename_without_ext="${filename%.*}"

    # Output WAV file path
    output="$DIR/$filename_without_ext.wav"

    # Convert using FFmpeg
    echo "🎵 Converting: $file -> $output"
    ffmpeg -i "$file" "$output" -y
  else
    echo "⚠️ No .aac files found in $DIR"
  fi
done

echo "✅ Conversion complete!"
