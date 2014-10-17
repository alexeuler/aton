class Boiler

  Types = ['K', 'L', 'M', 'N']

  attr_accessor :spare_parts, :id, :sheet, :type

  def initialize(spare_parts_count)
    @spare_parts=Array.new(spare_parts_count, 0)
  end

  def self.load(spare_parts, references)
    result = []
    count = spare_parts.count
    references.each do |ref|
      if ref.sheet == 'Зборка' or ref.sheet == 'ГПП'
        Types.each do |type|
          boiler = self.new count
          boiler.id = ref.id
          boiler.sheet = ref.sheet
          boiler.type = type
          result << boiler
        end
      end
    end
    result
  end
end