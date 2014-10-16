require_relative 'lib/config'
require_relative 'lib/spare_part'
parts = SparePart.read_from_file(AppConfig::Root+'/data/InventoryUTF-8.txt')
s=1