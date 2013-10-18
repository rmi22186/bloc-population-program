require_relative 'lib/setup'
require_relative 'lib/analytics'


class Population
  attr_accessor :analytics

  def initialize
    areas = Setup.new().areas                 #
    @analytics = Analytics.new(areas)
  end

  def menu
    system 'clear'                                      # clears the screen to make it more readable by the user
    puts "Population Menu"                              # puts title of population at top
    puts "---------------"                              # puts separator between title and menu option
    @analytics.options.each do |opt|                    # grab options from analytics
      puts "#{opt[:menu_id]}. #{opt[:menu_title]}"      # put the option menu_id # and menu_title
    end
  end

  def run                                               # difference between run as a method without an argument (here in population.rb), vs run with an argument from analytics.rb
    stop = false                                        # why are they assigning stop to "false" here?

    while stop != :exit do                              # so long as stop doesn't equal :exit, run the menu, print "Choice" and grab a number from user
      self.menu                                         # why do we need "self.menu" in order to run the menu, and not just "menu"? "menu" alone seems to work when i ran the program, but just curious as to why they have self here
      print "Choice: "
      choice = gets.strip.to_i                          # assign choice variable to what user inputs and turn to an integer.  this is now taken as a hash
      # run their choice
      stop = @analytics.run(choice)                     # assign stop variable to 
      if stop == :exit
        puts "Exiting"
      else
        print "\nHit enter to continue "                # if not exit, then show this string to prompt user
        gets
      end
    end
  end
end

p = Population.new
p.run