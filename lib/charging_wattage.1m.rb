#!/usr/bin/env ruby

require 'yaml'

output = `system_profiler SPPowerDataType`

output = YAML.load(output)
power = output["Power"]
ac_power = power["AC Charger Information"]
wattage = ac_power["Wattage (W)"]

puts wattage

