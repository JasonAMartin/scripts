require 'Core'
require 'Stats'

some_string = "meh "
Core.trim_string(some_string)


# IN core.rb
module Core
	MODULE_NAME = 'Example'
	def self.echo
		puts "Core is activated."
	end

	def self.trim_string(str)
  		return str.tr(' ', '')
	end
end
