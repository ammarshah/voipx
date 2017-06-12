class CreateProductsService
  def call
    Product.delete_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE products_id_seq RESTART WITH 1")

    Product.create(name: "Wholesale")
    Product.create(name: "Retail")
    Product.create(name: "Calling Cards")
    Product.create(name: "Call Shops")
    Product.create(name: "Accessories")
    Product.create(name: "Mobile Equipments")

    Product.all.collect { |product| product.name }
  end
end
