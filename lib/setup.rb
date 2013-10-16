require_relative 'csv_reader'   # if you do require a file in a different folder, where do you put the path name?
require_relative 'area'         # these 2 lines are used to access classes from other .rb files


class Setup

  attr_accessor :areas
  def initialize
    csv = CSVReader.new("./zipcode-db.csv")   # calling a new CSVReader class using the csv file and assigning it to variable csv

    @areas = []                 # creates empty @area instance
    csv.read do |item|          # calls read method from csv_reader.rb on csv, which is the read only file
      @areas << Area.new(item)  # unsure exactly what happens here as read method is processed??? are only zip code, estimated population, city, and state passed into each @area instance?
    end

    self                        # why is "self" being returned?  what will self be?
  end
end

