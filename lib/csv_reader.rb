# BLOC.IO - "Responsible for taking in the csv and passing back each area as a hashes"      # read row, return as a hash.  setup is now turning into an area

class CSVReader
  
  attr_accessor :fname, :headers    # make it so "fname" and "headers" variables can be set as instance variables
  
  def initialize(filename)          # automatically run when program starts, "filename" is just local variable
    @fname = filename               # create instance variable for filename to be used in other methods
  end

  def read                          
    f = File.new(@fname, 'r')       # initiate read only view of file.  when a giant file is being read, where is the temporary data being stored???
    self.headers = f.readline       # Grab the first line, which initially is one long string???  readline = first line?
    
    while (!f.eof? && next_line = f.readline)   # I understand the while it is not the end of the file, but where does "&& next_line = readline" come in, that doesn't seem to be a condition???, nextline = readline in case theres any empty lines below
      values = next_line.split(',')             # values is now an array, because we are splitting the CSV by comma.  value can be called whatever
      hash = create_hash(values)                # create_hash is being pulled from the method below
      yield(hash)                               # 
    end
  end

  def headers=(header_str)                      # why is there an equals sign here? what is the difference between defining methods with and without =
    @headers = header_str.split(',')            # why is this separated from the self.headers = f.readline above?

    @headers.map! do |h|                        # would "each" serve the same purpose as map! here?  kind of confused about each do vs map do
      h.gsub!('"', '')                          # remove quotes
      h.strip!                                  # remove extra spaces
      h.underscore.to_sym                       # Rubify the name of each column and convert to a symbol to be used as a key in hash
    end
  end

  def create_hash(values)                       # values is the array being passed into this -- what is the difference between the hashes being created here and the one fromt he "def read" section above?
    h = {}                                      # create empty hash. hash needed to combine header (key) and row (value)
    @headers.each_with_index do |header, i|     # each with index assigns each header an index number in the array 
      value = values[i].strip.gsub('"', '')     # 
      h[header] = value unless value.empty?     # each header from ln38 is being passed into the hash as a key and being set as the value unless the value is empty.  if the value is empty is the value = nil?
    end
    h
  end
end

class String                                    # REGEX for converting to snake case to Rubify words
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end
