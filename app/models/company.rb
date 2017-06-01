class Company < ApplicationRecord
  # Associations
  has_many :users, dependent: :destroy

  # Validations
  validates_presence_of :name, :country_code, :website, :phone_no
  validate              :uniqueness_of_name_with_slug, on: :create
  validates             :website, url: true

  # Callbacks
  before_create :generate_slug

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
end
