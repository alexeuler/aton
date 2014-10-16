class SparePart
  attr_accessor :id, :name, :formula, :quantity, :warehouse, :reqs

  def self.read(tuple)
    result = self.new
    data = tuple.split(';')
    result.id=data[1]+data[2]
    result.name=data[3]
    result.quantity=data[4]
    result.reqs=data[5]
    result.formula=data[6]
    result.warehouse=data[7]
    result
  end

  def self.read_from_file(source)
    result = []
    File.open(source, "r") do |f|
      f.each_line do |line|
        spare_part = self.read(line)
        result << spare_part
      end
    end
    result
  end

end
