#!/usr/bin/env ruby

title = ARGV.shift
description = ARGV.shift
command = "osascript -e \"display notification \\\"#{description}\\\" with title \\\"#{title}\\\"\""
spawn command
