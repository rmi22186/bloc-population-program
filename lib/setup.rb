require_relative 'csv_reader'   # if you do require a file in a different folder, where do you put the path name?
require_relative 'area'         # these 2 lines are used to access classes from other .rb files


class Setup

  attr_accessor :areas

  def initialize
    csv = CSVReader.new("./zipcode-db.csv")   # create a new CSVReader class using the csv file and assigning it to variable csv.  Is this where it links to csv_reader def initialize?

    @areas = []                 # creates empty @area instance to be filled with [?zip code, estimated_population, city, state?] from areas.rb?
    csv.read do |item|          # calls read method from csv_reader.rb on csv, which is the read only file.  item is a hash bc we're yielding a hash from csv_reader
      @areas << Area.new(item)  # unsure exactly what happens here as read method is processed??? are only zip code, estimated population, city, and state passed into each @area instance?
    end

    self                        # why is "self" being returned?  what will self be?
  end
end