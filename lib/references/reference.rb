class Reference
  attr_accessor :formula, :id, :sheet
  def self.read(tuple)
    data = tuple.split(';')
    result = self.new
    result.id = data[1]
    result.sheet = data[3].chomp
    result.formula = result.sheet+'!'+data[0]
    result
  end
end