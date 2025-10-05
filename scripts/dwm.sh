#!/bin/sh
xinput list
echo "What is the ID of your mouse?"
read input

xinput set-prop "$input" "libinput Accel Speed" 0 &
xinput set-prop "$input" "libinput Accel Profile Enabled" 0 1 &

echo "Mouse acceleration disabled."
