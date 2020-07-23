class PhoneValidator < ActiveModel::EachValidator
  # @todo: this is just a US phone validation if we want to validate
  # other countries validation, logic should be updated
  PHONE_REGEX = /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :phone)  unless value =~ PHONE_REGEX
  end
end
