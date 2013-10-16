class Area

  attr_accessor :zipcode, :estimated_population, :city, :state

  def initialize(hash)
    @zipcode = hash[:zipcode].to_i || 0                                   # what each Area class will contain?
    @estimated_population = hash[:estimated_population].to_i || 0         # what each Area class will contain?
    @city = hash[:city] || "n/a"                                          # what each Area class will contain?
    @state = hash[:state] || "n/a"                                        # what each Area class will contain?
  end

  def to_s
    "#{city}, #{state} #{zipcode} has #{estimated_population} people."    # saw that "option 5 - info for given zip code" uses this, but can't tell how or where the code is?
  end
end