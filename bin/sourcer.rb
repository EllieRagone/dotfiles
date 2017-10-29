#!/usr/bin/env ruby
sourced = ARGV.shift
exec "zsh -c 'source #{sourced} && /usr/bin/env ruby #{ARGV.join(" ")}'"
