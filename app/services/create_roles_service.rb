class CreateRolesService
  def call
    Role.delete_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE roles_id_seq RESTART WITH 1")

    Role.create(name: "admin")
    Role.create(name: "user")
    Role.create(name: "company_admin")

    Role.all.collect { |role| role.name }
  end
end
