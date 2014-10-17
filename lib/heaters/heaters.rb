require_relative 'heater'

class Heaters

  def initialize(source)
    @hash = {}
    File.open(source, 'r') do |f|
      f.each_line do |line|
        heater = Heater.read(line)
        @hash[heater.id] = heater.formula
      end
    end
  end

  def get_formula(id)
    @hash[id]
  end
end