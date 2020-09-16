#!/bin/bash

command -v jq >/dev/null 2>&1 || { echo >&2 “jq missing.”; exit1; }

SANDIEGO="KSAN"
ALBANY="KALB"
PORTLANDME="KPWM"
ELMIRA="KELM"
MIDLAND="KMDD"
ERIE="KERI"
ROCHESTER="KROC"
LONGMEADOW="KBDL"

STATION=$LONGMEADOW

URL="https://api.weather.gov/stations/$STATION/observations/current"

temperature_jq=".temperature.value"
conditions_jq=".textDescription"
coordinates_jq=".geometry.coordinates"
longitude_jq="$coordinates_jq[0]"
latitude_jq="$coordinates_jq[1]"

# conditions = ["Clear", "Mostly Clear"]

result="curl -s $URL"
result=`$result`

if [ "$1" = "open" ]; then
  # WEB_URL="https://forecast.weather.gov/MapClick.php?lat=$latitude&lon=$longitude"
  # echo $WEB_URL
  longitude=`echo $result | /usr/local/bin/jq "$longitude_jq"`
  latitude=`echo $result | /usr/local/bin/jq "$latitude_jq"`
  WEB_URL="https://forecast.weather.gov/MapClick.php?lat=$latitude&lon=$longitude"
  open $WEB_URL
  exit
fi
temperature=`echo $result | /usr/local/bin/jq ".properties$temperature_jq"`
temperature=`bc <<< "scale=8; ($temperature*(9/5)) + 32"`
temperature=`printf "%.0f" $temperature`



echo $temperature°F

