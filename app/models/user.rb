class User < ApplicationRecord
  rolify

  attr_accessor :account_type
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates_presence_of :first_name, :last_name

  # Associations
  belongs_to :company, optional: true

  accepts_nested_attributes_for :company, reject_if: :all_blank

  after_initialize :set_default_account_type
  after_create :assign_role


  private
  def is_a_company_admin?
    return false if company.nil?
    company.users.count == 1 ? true : false
  end

  def assign_role
    if is_a_company_admin?
      add_role(:company_admin)
    else
      add_role(:user)
    end
  end

  def set_default_account_type
    self.account_type ||= "individual"
  end
end