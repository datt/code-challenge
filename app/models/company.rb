class Company < ApplicationRecord
  has_rich_text :description

  validates :name, presence: true
  validates :email, allow_blank: true, uniqueness: true, company_email: true
  validates :phone, allow_blank: true, uniqueness: true, phone: true

  before_save :email_downcase, if: :email_changed?
  before_save :update_city_and_state, if: :zip_code_changed?

  # updates the attributes city and state if zip code is changed.
  def update_city_and_state
    zip_code_data = fetch_zipcode_data
    return validate_zip_code unless zip_code_data.present?

    self.city = zip_code_data[:city]
    self.state = zip_code_data[:state_code]
  end

  private

  # to make sure the uniqueness logic works well
  def email_downcase
    self.email = email.downcase if email.present?
  end

  # @todo Can be moved to custom validator if required in more than 1 model
  def validate_zip_code
    errors.add(:zip_code, I18n.t('company.errors.zip_code'))
    false
  end

  # @return [Hash] hash contains keys city, state_name, state_code, time_zone
  # @example { state_code: "CA", state_name: "California", city: "San Francisco", time_zone: "America/Los_Angeles" }
  def fetch_zipcode_data
    ZipCodes.identify(zip_code)
  end
end

# Suggetions/Opinion: I would rather prefer having separate model something like
# address i.e. company has_many/has_one addresses/address
# Address: belongs_to :company, fields: address, zipcode, city_id, state_id etc.
# Having our Own DB of city and states