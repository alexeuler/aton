class Boiler

  attr_accessor :spare_parts, :id, :type

  def initialize(spare_parts_count)
    @spare_parts=Array.new(spare_parts_count, 0)
  end

  def self.load(spare_parts, references)
    result = []
    count = spare_parts.count
    references.each do |ref|
      if ref.sheet == 'Зборка' or ref.sheet == 'ГПП'
        boiler = self.new count
        boiler.id = ref.id
        boiler.type = ref.sheet
        result << boiler
      end
    end
    result
  end
end