# frozen_string_literal: true

SimpleForm.setup do |config|
  config.wrappers(
    :default,
    tag: "div",
    class: :"form-control",
    error_class: :"form-field-errors",
  ) do |b|
    b.use(:html5)
    b.use(:placeholder)

    b.optional(:maxlength)
    b.optional(:minlength)

    b.optional(:pattern)
    b.optional(:min_max)

    b.optional(:readonly)

    b.use(:label, class: "label", error_class: :error)
    b.use(:input, class: "input input-bordered", error_class: "input-error")
    b.use(:error, wrap_with: { tag: :p, class: "text-error" })
  end

  config.wrappers(
    :inline,
  ) do |b|
    b.use(:placeholder)
    b.use(:input, class: "input input-bordered", error_class: "input-error")
    b.use(:error, wrap_with: { tag: :p, class: "text-error" })
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
