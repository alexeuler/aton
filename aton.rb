require_relative 'lib/boot'
# require_relative 'lib/spare_part'
# parts = SparePart.read_from_file(AppConfig::Root+'/data/InventoryUTF-8.txt')
form = '#=2*(Зборка!O95+Зборка!O96+Зборка!O97+Зборка!O98)'

x = App::Formula.translate(form)

s=1
