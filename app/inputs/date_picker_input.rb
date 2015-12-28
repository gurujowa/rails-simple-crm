class DatePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    @builder.text_field(attribute_name, input_html_options.merge(datepicker_options(object.send(attribute_name))))
  end

  def datepicker_options(value = nil)
    formatted_value = value.nil? ? nil : value.to_s(:date)
    { value: formatted_value, :dateFormat => "yy/mm/dd", :class => "datepicker form-control"}
  end
end
