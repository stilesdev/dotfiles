#!/usr/bin/env bash

if synclient -l | grep "TouchpadOff .*=.*0" ; then
    synclient TouchpadOff=1 ;
    synclient ClickFinger1=0 ;
    synclient ClickFinger2=0 ;
else
    synclient TouchpadOff=0 ;
    synclient ClickFinger1=1 ;
    synclient ClickFinger2=3 ;
fi
