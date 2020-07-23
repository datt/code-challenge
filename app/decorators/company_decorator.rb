module CompanyDecorator
  LEAD_JOINER = ' -- '.freeze
  CITY_STATE_JOINER = ', '.freeze

  def city_state
    if city.present? || state.present?
      compacted_array([city, state]).join(CITY_STATE_JOINER)
    else
      'Not available'
    end
  end

  def lead
    compacted_array([phone, email]).join(LEAD_JOINER)
  end

  private

  def compacted_array(array)
    array.map(&:presence)
         .compact
  end
end