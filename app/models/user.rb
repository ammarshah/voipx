class User < ApplicationRecord
  rolify

  attr_accessor :account_type         # Just a virtual attribute to check if it's a company signup or an individual
  attr_accessor :selected_company_id  # Just a virtual attribute to temporary store/retrieve company id and then assign it to actual company_id column in before_create callback
  
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
  before_create :assign_company, if: :company_already_exists?
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
    self.selected_company_id.blank? ? false : true
  end

  def this_the_case
    is_an_individual? || company_already_exists?
  end

  def assign_company
    self.company_id = self.selected_company_id    
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