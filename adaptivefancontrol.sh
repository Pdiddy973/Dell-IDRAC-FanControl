function get_temp {
  local TEMP=$(ipmitool -I lanplus -H $IDRAC_HOST -U $IDRAC_USER -P $IDRAC_PW sdr type temperature | grep Exhaust | grep -o -e '[0-9][0-9] degrees' | grep -o -e '[0-9][0-9]')
  echo $TEMP
}

function set_speed {
  ipmitool -I lanplus -H $IDRAC_HOST -U $IDRAC_USER -P $IDRAC_PW raw 0x30 0x30 0x02 0xff $HEX > /dev/null
}

TEMP=$(get_temp)
    if [ "$TEMP" -ge 0 ] && [ "$TEMP" -lt 35 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 20%"
        HEX=0x14
        set_speed
    elif [ "$TEMP" -ge 35 ] && [ "$TEMP" -lt 40 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 30%"
        HEX=0x1e
        set_speed
    elif [ "$TEMP" -ge 40 ] && [ "$TEMP" -lt 45 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 40%"
        HEX=0x28
        set_speed
    elif [ "$TEMP" -ge 45 ] && [ "$TEMP" -lt 50 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 50%"
        HEX=0x32
        set_speed
    elif [ "$TEMP" -ge 50 ] && [ "$TEMP" -lt 55 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 60%"
        HEX=0x3c
        set_speed
    elif [ "$TEMP" -ge 55 ] && [ "$TEMP" -lt 60 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 70%"
        HEX=0x46
        set_speed
    elif [ "$TEMP" -ge 60 ] && [ "$TEMP" -lt 70 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 80%"
        HEX=0x50
        set_speed
    elif [ "$TEMP" -ge 70 ] && [ "$TEMP" -lt 80 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 90%"
        HEX=0x5a
        set_speed
    elif [ "$TEMP" -ge 80 ] && [ "$TEMP" -le 100 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 100%"
        HEX=0x64
        set_speed
    else
        echo "Temperature $TEMP: Was not able to get proper tempature"
fi

sleep "$CHECK_INTERVAL"s
exec "/opt/adaptivefancontrol.sh"