class User < ApplicationRecord
  rolify
  has_paper_trail only: [:sign_in_count]

  attr_accessor :selected_company_id  # Just a virtual attribute to temporary store/retrieve company id and then assign it to actual company_id column in before_create callback
  attribute :add_company_bool, :boolean, default: false # Just a virtual attribute to persist 'would you like to add your company' boolean attr value on edit user profile page.
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Mailboxer
  acts_as_messageable

  # CarrierWave
  mount_uploader :photo, PhotoUploader
  mount_uploader :cover, CoverUploader

  # Validations
  validates_presence_of :first_name, :last_name
  # validates_presence_of :country_code, on: :update
  # validates             :facebook_url, :twitter_url, :linkedin_url, url: { allow_blank: true }
  validate              :email_with_company_website, if: :adding_company?
  
  # Associations
  belongs_to :company, optional: true
  has_many :routes, dependent: :destroy
  has_many :contacts, foreign_key: 'owner_id', dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_many :notified_matches, dependent: :destroy
  has_many :requested_breakouts, dependent: :nullify

  # Nested Attributes for company
  accepts_nested_attributes_for :company,
    reject_if: :reject_company, 
    allow_destroy: true

  # Callbacks
  after_create :assign_role
  before_update :assign_company, if: :company_already_exists?
  after_update :assign_company_admin_role, if: :company_id_changed?
  after_create :subscribe_to_pro_plan # this offer is only for signups before 1st March, 2018

  def subscribe_to_pro_plan
    Subscription.create(user_id: self.id, plan_id: Plan.find_by_name('Pro').id) if Date.today < Date.new(2018,3,1) # i.e. 1st March, 2018
  end

  def name
    self.first_name + " " + self.last_name if self.first_name and self.last_name
  end

  def has_subscribed_to_basic_plan?
    return true if subscription.nil?
    subscription.plan.name == "Basic"
  end

  def has_subscribed_to_pro_plan?
    return false if subscription.nil?
    subscription.plan.name == "Pro"
  end

  def allowed_to_send_message?
    has_subscribed_to_pro_plan? || (has_subscribed_to_basic_plan? && contacts.size < 5)
  end

  def contacts_left
    5 - contacts.size
  end

  def profile_completed?
    !(first_name.blank? or
      last_name.blank? or
      position.blank? or
      about.blank? or
      photo.blank? or
      skype.blank? or
      phone.blank? or
      country_code.blank? or
      facebook_url.blank? or
      twitter_url.blank? or
      linkedin_url.blank?)
  end

  def social_links_present?
    !facebook_url.blank? or
    !twitter_url.blank? or
    !linkedin_url.blank?
  end

  def has_company?
    user = User.find self.id
    !user.company_id.blank?
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end

  def country_name
    return if country_code.blank?
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end

  def facebook_url_with_protocol
    "https://wwww.facebook.com/#{self[:facebook_url]}"
  end

  def twitter_url_with_protocol
    "https://www.twitter.com/#{self[:twitter_url]}"
  end

  def linkedin_url_with_protocol
    "https://www.linkedin.com/in/#{self[:linkedin_url]}"
  end

  def is_company_admin_of company
    self.company == company && self.has_role?(:company_admin)
  end
  
  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted? 
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  def password_match?
    self.errors[:password] << I18n.t('errors.messages.blank') if password.blank?
    self.errors[:password_confirmation] << I18n.t('errors.messages.blank') if password_confirmation.blank?
    self.errors[:password_confirmation] << I18n.translate("errors.messages.confirmation", attribute: "password") if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  # new function to set the password without knowing the current 
  # password used in our confirmation controller. 
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore. 
  # Instead you should use `pending_any_confirmation`.  
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  private
  def reject_company
    self.add_company_bool == false || company_already_exists?
  end

  # def reject_company(attributes)
  #   all_company_fields_blank?(attributes) || company_already_exists?
  # end

  # def all_company_fields_blank?(attributes)
  #   attributes['name'].blank? && attributes['country_code'].blank? && attributes['website'].blank? && attributes['phone_no'].blank?
  # end

  def is_a_company_admin?
    return false if company.nil?
    company.users.count == 1 ? true : false
  end

  def company_already_exists?
    self.selected_company_id.blank? ? false : true
  end

  def assign_company
    self.company_id = self.selected_company_id    
  end

  def assign_role
    add_role(:user)
  end

  def assign_company_admin_role
    add_role(:company_admin) if is_a_company_admin?
  end

  def adding_company?
    return false if self.company.blank? && self.selected_company_id.blank?

    if self.selected_company_id.present? || self.company.new_record?
      return true
    else
      return false
    end
  end

  def email_domain
    # self.email.gsub(/.+@([^.]+).+/, '\1')
    self.email.split('@').second
  end

  def email_with_company_website
    if self.email.present?
      if self.company.present?
        return if !self.company.valid? && self.company.errors.include?(:website)
        company = self.company
      else
        return if !self.selected_company_id.present?
        company = Company.find_by_id(self.selected_company_id)
      end

      if Company.website_domain(company) == email_domain
        return true
      else
        errors.add(:email, "Use your official email address. e.g : someone@" + Company.website_domain(company))
        return false
      end
    end
  end
end