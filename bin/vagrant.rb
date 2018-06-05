#!/usr/bin/env ruby /Users/pragone/bin/sourcer.rb /Users/pragone/.zshenv

require 'optparse'
require 'ostruct'

class Vagrant
  FIELDS = [:id, :name, :type, :status, :location]

  attr_accessor :options

  def self.global_status
    results = `vagrant global-status`.split("\n")[2..-8]
    results.map do |machine|
      OpenStruct.new(Hash[FIELDS.zip(machine.split(" ").map(&:strip))])
    end
  end

  def self.status(machine_id)
    result = `vagrant status #{machine_id}`
    _, status, _ = result.split("\n")[2].split(" ")
    return status
  end

  def self.up(machine_id)
    system "/usr/local/bin/vagrant up #{machine_id}#{debug}"
  end

  def self.ssh(machine_id)
    command = "/usr/bin/osascript /Users/pragone/bin/opentab.scpt \"vagrant ssh #{machine_id}\""
    exec command
  end

  def self.suspend(machine_id)
    system "/usr/local/bin/vagrant suspend #{machine_id}#{debug}"
  end

  def self.debug
    @options.debug ? " --debug &> #{@options.debug_file}" : ""
  end

  def self.run!
    @options = OpenStruct.new
    @options.debug = false
    @options.debug_file = "/tmp/vagrant.rb.log"

    OptionParser.new do |opts|
      opts.banner = "Usage: vagrant.rb [options] <command> <machine>"

      opts.on("-d", "--debug", "Log debug/info status") do |v|
        @options.debug = v
      end

      opts.on("-f", "--file FILE", "Debug file location (default=/tmp/vagrant.rb.log)") do |v|
        @options.debug_file = v
      end
    end.parse!

    action = ARGV.shift
    machine_id = ARGV.shift
    machine_name = ARGV.shift

    case action
    when "up"
      notify("Booting #{machine_id}", "Booting #{machine_name}")
      up(machine_id)
      notify("Machine booted!", "#{machine_name} booted!")
    when "suspend"
      notify("Suspending machine", "Suspending #{machine_name}")
      suspend(machine_id)
      notify("Machine suspended!", "#{machine_name} suspended!")
    when "ssh"
      notify("SSH machine", "SSHing into #{machine_name}")
      ssh(machine_id)
    end
  end

  def self.notify(title="", description="")
    spawn "/Users/pragone/bin/notify.rb \"#{title}\" \"#{description}\""
  end
end

if ARGV.size > 0
  Vagrant.run!
end
