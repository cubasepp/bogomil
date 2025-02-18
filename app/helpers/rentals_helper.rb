# frozen_string_literal: true

module RentalsHelper
  def rent_type_options
    Rent::RENT_TYPES.map do |type|
      [t("simple_form.labels.rent.rent_types.#{type}"), type]
    end
  end
end
