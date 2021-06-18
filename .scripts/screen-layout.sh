#!/bin/sh

if [ $(xrandr | grep " connected" | wc -l) -eq 1 ]; then
    # Single screen, typically no need to change resolutions.
    echo "Auto"
    xrandr --auto
else
    if (xrandr | grep "DisplayPort-0" -A1 | grep "2560x1080" >> /dev/null) && (xrandr | grep "DisplayPort-1" -A1 | grep "1920x1200" >> /dev/null); then
        echo "Home Office"
        autorandr office-default
#        while (xrandr | grep "panning" >> /dev/null); do
#            # Make sure panning is fully disabled
#            xrandr --output DisplayPort-0 --auto --panning 0x0+0+0/0x0+0+0/0/0/0/0 --output DisplayPort-1 --auto --panning 0x0+0+0/0x0+0+0/0/0/0/0
#            sleep 3
#        done
#        xrandr --output DisplayPort-0 --primary --mode 2560x1080 --rate 85 --pos 1200x460 --rotate normal --output DisplayPort-1 --mode 1920x1200 --pos 0x0 --rotate left --output DisplayPort-2 --off --output DisplayPort-3 --off
    elif xrandr | grep "DP-0" | grep "3440x1440" >> /dev/null && xrandr | grep "HDMI-0" | grep "3440x1440" >> /dev/null; then
        # Ultrawide monitor picture-by-picture
        echo "Ultrawide PBP"
        xrandr --output DP-0 --primary --mode 1720x1440 --pos 0x0 --rotate normal --output HDMI-0 --mode 1720x1440 --right-of DP-0 --rotate normal --output DVI-D-0 --off --output HDMI-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off
    else
        echo "No match"
    fi
fi
