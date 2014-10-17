class Reference
  attr_accessor :formula, :id
  def self.read(tuple)
    data = tuple.split(';')
    result = self.new
    result.id = data[1]
    result.formula = data[3].chomp+'!'+data[0]
    result
  end
end