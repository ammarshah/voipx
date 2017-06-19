class Company < ApplicationRecord
  # Paperclip
  has_attached_file :logo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }, default_url: "/missing-images/:style/missing-profile.png"

  # Associations
  has_many :users, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :references, dependent: :destroy
  has_and_belongs_to_many :products
  has_many :other_products, dependent: :destroy

  # Validations
  validates_presence_of :name, :country_code, :website, :phone_no
  validate              :uniqueness_of_name_with_slug, on: :create
  validate              :website_validator, if: 'website.present?'
  validates_attachment  :logo, content_type: { content_type: /\Aimage\/.*\Z/ }

  # Callbacks
  before_create :generate_slug

  accepts_nested_attributes_for :reports, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :references, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :other_products, reject_if: :all_blank, allow_destroy: true

  def website_with_protocol
    "http://#{self[:website]}"
  end

  def country_name
    return if country_code.blank?
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end

  private
  def strip_name_like_a_boss
    self.name.downcase.gsub(" ", "").strip.squish   #`.strip` and `.squish` were not needed btw but our method name demands it :D
  end

  def generate_slug
    self.slug = strip_name_like_a_boss
  end

  def uniqueness_of_name_with_slug
    stripped_name = strip_name_like_a_boss
    if self.class.exists?(slug: stripped_name)
      errors.add(:name, "already exists.")
      return false
    else
      return true
    end
  end

  def website_validator
    errors.add(:website, "is not a valid URL") unless website_valid?
  end

  def website_valid?
    company_website = "http://#{self.website}"
    !!company_website.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix) # found regex here: https://stackoverflow.com/a/43360816/4640611
  end
end
