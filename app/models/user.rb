class User < ApplicationRecord
  rolify

  attr_accessor :account_type # Just a virtual attribute to check if it's a company signup or an individual
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates_presence_of :first_name, :last_name

  # Associations
  belongs_to :company, optional: true

  # Nested Attributes for company
  accepts_nested_attributes_for :company,
    reject_if: :this_the_case, 
    allow_destroy: true

  # Callbacks
  after_initialize :set_default_account_type
  after_create :assign_role


  private
  def is_an_individual?
    self.account_type == 'individual' ? true : false
  end

  def is_a_company_admin?
    return false if company.nil?
    company.users.count == 1 ? true : false
  end

  def company_already_exists?
    self.company_id.nil? ? false : true
  end

  def this_the_case
    is_an_individual? || company_already_exists?
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