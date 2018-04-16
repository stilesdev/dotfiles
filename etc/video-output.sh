#!/usr/bin/env bash
#set -x

user="$(w -h | grep tty | head -n1 | awk '{print $1}')"

export DISPLAY=:0.0
export XAUTHORITY="/home/$user/.Xauthority"

hdmi_status="$(cat /sys/class/drm/card0-HDMI-A-1/status)"
dvi_status="$(cat /sys/class/drm/card1-DVI-I-1/status)"
vga_status="$(cat /sys/class/drm/card0-VGA-1/status)"

xrandr_init() {
	declare -i count=2
        declare -i seconds=1
        while ((count)); do
                xrandr >/dev/null
                sleep $seconds
                ((count--))
        done
	return 0
}

if [ "connected" == "$hdmi_status" ]; then
	xrandr_init
	/bin/su $user -c "xrandr --output eDP-1 --off"
	/bin/su $user -c "xrandr --output DVI-I-1-1 --off"
	/bin/su $user -c "xrandr --output VGA-1 --off"
	/bin/su $user -c "xrandr --output HDMI-1 --primary --auto --pos 0x0 --rotate normal"
elif [ "connected" == "$dvi_status" ]; then
	xrandr_init
	/bin/su $user -c "xrandr --output eDP-1 --off"
	/bin/su $user -c "xrandr --output HDMI-1 --off"
	/bin/su $user -c "xrandr --output VGA-1 --off"
	/bin/su $user -c "xrandr --output DVI-I-1-1 --primary --auto --pos 0x0 --rotate normal"
elif [ "connected" == "$vga_status" ]; then
	xrandr_init
	/bin/su $user -c "xrandr --output eDP-1 --off"
	/bin/su $user -c "xrandr --output HDMI-1 --off"
	/bin/su $user -c "xrandr --output DVI-I-1-1 --off"
	/bin/su $user -c "xrandr --output VGA-1 --primary --auto --pos 0x0 --rotate normal"
else
    /bin/su $user -c "xrandr --output HDMI-1 --off"
	/bin/su $user -c "xrandr --output DVI-I-1-1 --off"
	/bin/su $user -c "xrandr --output VGA-1 --off"
    /bin/su $user -c "xrandr --output eDP-1 --primary --auto --pos 0x0 --rotate normal"
fi

exit 0

