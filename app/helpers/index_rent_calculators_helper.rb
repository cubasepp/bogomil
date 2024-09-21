# frozen_string_literal: true

module IndexRentCalculatorsHelper
  def lower_camelize(value)
    value&.to_s&.camelize(:lower)
  end

  def selection_badge(frame_id, type, value, label, disabled: false)
    element_id = "#{frame_id}_#{type}"
    radio_button = radio_button_tag(element_id, value, false, {
      disabled:,
      class: "hidden peer",
      data: {
        "action": "click->index-rent-calculator#selectBadge",
        "type": type,
        "frame-id": lower_camelize(frame_id),
      },
    })
    radio_label = content_tag(
      :label,
      content_tag(:div, class: "block") do
        content_tag(:div, label, class: "w-full text-lg font-semibold")
      end,
      for: "#{element_id}_#{value}",
      class: "index-rent-calculator-selection-badge dark:peer-checked:text-blue-500 \
      peer-checked:border-blue-600 peer-checked:text-blue-600".squish,
    )
    content_tag(:div) do
      safe_join([radio_button, radio_label])
    end
  end
end
