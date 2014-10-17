class Heater
  attr_accessor :formula, :id, :sheet
  def self.read(tuple)
    data = tuple.split(';')
    result = self.new
    result.id = data[1]+data[2]
    result.sheet = data[7].chomp
    result.formula = data[6]
    result
  end
end