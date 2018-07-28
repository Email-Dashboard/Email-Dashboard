# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :default, class: :input,
                            hint_class: :field_with_hint, error_class: :field_with_errors do |b|

    b.use :html5

    b.use :placeholder

    b.optional :maxlength

    b.optional :minlength

    b.optional :pattern

    b.optional :min_max

    b.optional :readonly

    ## Inputs
    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default

  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = 'btn'

  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'error_notification'

  config.browser_validations = false

  config.boolean_label_class = 'checkbox'
end
