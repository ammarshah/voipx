class CreateAdminService
  def call
    admin = Admin.find_or_create_by!(email: Rails.application.secrets.admin_email) do |admin|
        admin.first_name = Rails.application.secrets.admin_first_name
        admin.last_name = Rails.application.secrets.admin_last_name
        admin.password = Rails.application.secrets.admin_password
        admin.password_confirmation = Rails.application.secrets.admin_password
        admin.confirm
      end
  end
end
