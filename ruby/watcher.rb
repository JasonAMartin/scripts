#!/usr/bin/env ruby

# A simple watch in Ruby using FileWatcher
# Docs: https://github.com/filewatcher/filewatcher

require 'filewatcher'
require 'pathname'

Filewatcher.new('~/temp/**/*.*', spinner: true, interval: 0.1).watch do |filename, event|
  puts filename
  puts event

  path = Pathname.new(filename)
  puts "Basename         : #{path.basename}"
  puts "Relative filename: #{File.join('.', path)}"
  puts "Absolute filename: #{path.realpath}"

  if filename.end_with? ".js"
    # do somethinig for JS files
    puts "Functional JS"
  elsif filename.end_with? ".less"
    # do something for LESS files
    puts "CSS !important"
  end

end
