require_relative 'reference'

class References

  include Enumerable
  attr_reader :hash, :data

  def initialize(source)
    @hash = {}
    @data = []
    File.open(source, 'r') do |f|
      f.each_line do |line|
        reference = Reference.read(line)
        @hash[reference.formula] = reference.id
        @data << reference
      end
    end
  end

  def each(&block)
    @data.each do |tuple|
      block.call(tuple)
    end
  end

  def self.get_id(formula)
    self.hash[formula]
  end

end