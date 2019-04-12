#!/usr/bin/env ruby
# You need to $ gem install highline
# This is just a starter stub example for creating a shell script with a menu in Ruby.

require 'highline'

cli = HighLine.new

cli.choose do |menu|
  menu.prompt = "My Starter Menu:  "
  menu.choice(:fun, nil,  'Have some fun.') { system("ls") }
  menu.choices(:alsofun, :morefun) { system("wc ~/.bashrc") }
  menu.choice(:Quit) { exit }
end
