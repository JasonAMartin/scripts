#!/usr/bin/env ruby

# A simple watch in Ruby using FileWatcher
# Docs: https://github.com/filewatcher/filewatcher

require 'filewatcher'

Filewatcher.new('~/some-dir').watch do |filename, event|
  puts filename
  puts event
end
