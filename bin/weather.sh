#!/bin/bash

STATION="KELM"

URL="https://api.weather.gov/stations/$STATION/observations/current"

temperature_jq=".temperature.value"
conditions_jq=".textDescription"

# conditions = ["Clear", "Mostly Clear"]

result="curl -s $URL"
temperature=`$result | jq ".properties$temperature_jq"`
temperature=`bc <<< "scale=8; ($temperature*(9/5)) + 32"`
temperature=`printf "%.0f" $temperature`

echo $temperature

