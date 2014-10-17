require_relative 'reference'

class References

  attr_reader :data

  def initialize(source)
    @data = {}
    File.open(source, 'r') do |f|
      f.each_line do |line|
        reference = Reference.read(line)
        @data[reference.formula] = reference.id
      end
    end
  end

  def self.get_id(formula)
    data[formula]
  end

end