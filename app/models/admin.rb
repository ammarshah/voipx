class Admin < User
  # Callbacks
  after_create :assign_role

  private

  def assign_role
    add_role(:admin)
  end
end