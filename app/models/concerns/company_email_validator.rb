class CompanyEmailValidator < ActiveModel::EachValidator
  # @todo This is simple email regex, can be updated to complex rules
  CO_EMAIL_REGEX = /^[a-z0-9._+-]+@getmainstreet.com$/i

  def validate_each(record, attribute, value)
    record.errors.add(attribute, :company_email) unless value =~ CO_EMAIL_REGEX
  end
end
