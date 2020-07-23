class Company < ApplicationRecord
  has_rich_text :description

  validates :name, presence: true
  validates :email, allow_blank: true, uniqueness: true, company_email: true
  validates :phone, allow_blank: true, uniqueness: true, phone: true

  before_save :email_downcase, if: :email_changed?

  private

  def email_downcase
    self.email = email.downcase if email.present?
  end
end
