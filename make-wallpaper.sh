#!/usr/bin/env bash

input="wall.png"
output="out.png"
logo="logo.svg"

#convert "$input" -blur 0x8 "$output"

# Get the width of the wallpaper
height=$(magick convert "$input" -format "%h" info:)
width=$(magick convert "$input" -format "%w" info:)

# Calculate appropriate height for logo on the wallpaper
logo_height=$(($height*9/16))


# Generate Mask
#rsvg-convert "$logo" -h $logo_height -f png | \
#convert png:- -gravity center -background white -extent "${width}x${height}" -flatten png:-


convert "$input" -write-mask <(rsvg-convert "$logo" -h $logo_height -f png | \
                                convert png:- -gravity center -background white \
                                    -extent "${width}x${height}" -flatten png:-) \
    -gravity center \
	-blur 0x30 \
	"$output"
