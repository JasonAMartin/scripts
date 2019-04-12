#!/usr/bin/env ruby

# A simple watch in Ruby using FileWatcher
# Docs: https://github.com/filewatcher/filewatcher

require 'filewatcher'

Filewatcher.new('~/some-dir').watch do |filename, event|
  puts filename
  puts event
  if filename.end_with? ".js"
    # do somethinig for JS files
    puts "Functional JS"
  elsif filename.end_with? ".less"
    # do something for LESS files
    puts "CSS !important"
  end

end
