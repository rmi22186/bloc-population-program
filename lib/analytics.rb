# queries the csv file that we loaded in csv reader

class Analytics
  attr_accessor :options

  def initialize(areas)         
    @areas = areas
    set_options                 # pulls in ln9-ln17
  end

  def set_options             # options array includes hashes, each option hash has a menu_id, menu_title, and method symbol
    @options = []
    @options << { menu_id: 1, menu_title: 'Areas count', method: :how_many }
    @options << { menu_id: 2, menu_title: 'Smallest Population (non 0)', method: :smallest_pop }
    @options << { menu_id: 3, menu_title: 'Largest Population', method: :largest_pop }
    @options << { menu_id: 4, menu_title: 'How many zips in California?', method: :california_zips }
    @options << { menu_id: 5, menu_title: 'Information for a given zip', method: :zip_info }
    @options << { menu_id: 6, menu_title: 'Exit', method: :exit }
  end

  def run(choice)             # takes a number as an argument and picks option from menu to run the associated method
    opt = @options.select {|o| o[:menu_id] == choice }.first      # why is this ".first" here?
    if opt.nil?
      puts "Invalid choice"
    elsif opt[:method] != :exit
      self.send opt[:method]
      :done
    else
      opt[:method]
    end
  end

  def how_many
    puts "There are #{@areas.length} areas"   # @areas has all rows in it as arrays, length would be total number of areas
  end

  def smallest_pop
    sorted = @areas.sort do |x, y|                            # normal sort method of x, y x <=> y
      x.estimated_population <=> y.estimated_population
    end
    smallest = sorted.drop_while { |i| i.estimated_population == 0 }.first    # a bit confused about drop_while...but drop_while removes all array items up to a certain certain criteria, in this case where estimated_population == 0.  list has been sorted, so all 0s are in the beginning, then .first calls next item (now first), which is smallest
    puts "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}"
  end

  def largest_pop
    sorted = @areas.sort do |x, y|                                  # normal sory by method.
      x.estimated_population <=> y.estimated_population             # instead of doing x <=> y, can I do y <=> and then remove the reverse on ln49?
    end
    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0 }.first   # do we even need drop_while here, if we sort from highest to lowest, the highest number will be first with no nil/empties, right?
    
    puts "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}"
  end

  def california_zips
    c = @areas.count { |a| a.state == "CA" }                        # count passes an argument that is used as a filter
    puts "There are #{c} zip code matches in California"
  end

  def zip_info
    print "Enter zip: "                                             # prompt user for zip code
    zip = gets.strip.to_i                                           # gets takes prompt from user, then takes any trailing or leading whitespace off, then turns it into an integer
    zips = @areas.select { |a| a.zipcode == zip }                   # creates an array from @area where zip = user input
    unless zips.empty?
      puts ""
      zips.each { |z| puts z }                                      #  iterate on the zips array to display |z|. if you put an object, automatically puts .to_s, we define .to_s in area.rb
    else
      puts "Zip not found"                                          # otherwise, show zip not found
    end
  end
end
