## Create Roles
roles = CreateRolesService.new.call
puts 'CREATED ROLES: ' << roles.join(', ')

## Create Products
products = CreateProductsService.new.call
puts 'CREATED PRODUCTS: ' << products.join(', ')