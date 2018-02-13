## Add Roles
roles = CreateRolesService.new.call
puts 'CREATED ROLES: ' << roles.join(', ')

## Add Plans
plans = CreatePlansService.new.call
puts 'CREATED Plans: ' << plans.join(', ')

## Add Products
products = CreateProductsService.new.call
puts 'CREATED PRODUCTS: ' << products.join(', ')

## Add Countries
countries = CreateCountriesService.new.call
puts 'CREATED Countries: ' << countries.join(', ')

## Add Admin
admin = CreateAdminService.new.call
puts 'CREATED ADMIN: ' << admin.email