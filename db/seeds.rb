## Add Roles
roles = CreateRolesService.new.call
puts 'CREATED ROLES: ' << roles.join(', ')

## Add Products
products = CreateProductsService.new.call
puts 'CREATED PRODUCTS: ' << products.join(', ')

## Add Countries
countries = CreateCountriesService.new.call
puts 'CREATED Countries: ' << countries.join(', ')