#!/bin/bash
#
# ~/.xinitrc
#

# for ibus
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=xim
# export XMODIFIERS=@im=ibus
# LC_ALL=en_US.UTF-8 ibus-daemon --daemonize --xim &

# for fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx

# xmodmap ~/.speedswapper
xmodmap ~/.Xmodmap

case `hostname` in
menorca )
    xrandr --output HDMI1 --mode 1920x1080
    xrandr --output VGA1 --mode 1920x1080
    xrandr --output VGA1 --auto --right-of HDMI1
    ;;
trinity )
    xrandr --output DP-1 --mode 2560x1440
    xrandr --output DP-1 --right-of DP-2
    ;;
molokai )
    xrandr --output DVI-I-1 --mode 1024x768
    ;;
caster )
    xrandr --output HDMI-0 --right-of DVI-I-1
    xrandr --output DP-3 --left-of DVI-I-1
    xrandr --output HDMI-0 --rotate right
    ;;
bateau )
    ;;
* )
    ;;
esac


# for urxvt
xrdb ~/.Xresources
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

exec /usr/bin/i3
