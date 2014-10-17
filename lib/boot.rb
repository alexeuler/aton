require_relative 'references/references'
require_relative 'spare_part'

class AppConfig
  Root = File.expand_path('../', File.dirname(__FILE__))
  References = References.new(Root+'/data/ReferencesUTF-8.txt')
  SpareParts = SparePart.load(Root+'/data/InventoryUTF-8.txt')
end


