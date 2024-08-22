# frozen_string_literal: true

SimpleForm.setup do |config|
  config.wrappers(
    :default,
    tag: "div",
    class: :"form mb-5",
    error_class: :"form-field-errors",
  ) do |b|
    b.use(:html5)
    b.use(:placeholder)

    b.optional(:maxlength)
    b.optional(:minlength)

    b.optional(:pattern)
    b.optional(:min_max)

    b.optional(:readonly)

    b.use(:label, class: "form-label", error_class: :error)
    b.use(:input, class: "form-input", error_class: :error)
    b.use(:error, wrap_with: { tag: :p, class: :error })
  end

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.button_class = "btn-green"

  config.error_notification_tag = :div
  config.error_notification_class = "error_notification"

  config.browser_validations = false
  config.required_by_default = false
  config.boolean_label_class = "checkbox"
  config.input_class = nil
  config.generate_additional_classes_for = []
end
