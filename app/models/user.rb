class User < ApplicationRecord
  rolify

  attr_accessor :selected_company_id  # Just a virtual attribute to temporary store/retrieve company id and then assign it to actual company_id column in before_create callback
  attribute :add_company_bool, :boolean, default: false # Just a virtual attribute to persist 'would you like to add your company' boolean attr value on edit user profile page.
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Mailboxer
  acts_as_messageable

  # Paperclip
  has_attached_file :photo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }, default_url: "/missing-images/:style/missing-profile.png"

  has_attached_file :cover, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }, default_url: "/missing-images/:style/missing-cover.jpg"

  # Validations
  validates_presence_of :first_name, :last_name
  # validates_presence_of :country_code, on: :update
  # validates             :facebook_url, :twitter_url, :linkedin_url, url: { allow_blank: true }
  validate              :email_with_company_website, if: :adding_company?
  validates_attachment  :photo, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates_attachment  :cover, content_type: { content_type: /\Aimage\/.*\Z/ }

  # Associations
  belongs_to :company, optional: true
  has_many :routes, dependent: :destroy
  has_many :contacts, foreign_key: 'owner_id', dependent: :destroy
  has_many :favorites, dependent: :destroy

  # Nested Attributes for company
  accepts_nested_attributes_for :company,
    reject_if: :reject_company, 
    allow_destroy: true

  # Callbacks
  after_create :assign_role
  before_update :assign_company, if: :company_already_exists?
  after_update :assign_company_admin_role, if: :company_id_changed?

  def name
    self.first_name + " " + self.last_name if self.first_name and self.last_name
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