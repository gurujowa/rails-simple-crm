class DatePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    @builder.text_field(attribute_name, input_options)
  end

  def input_options
    { :dateFormat => "yy/mm/dd HH:ii:ss", :class => "datepicker form-control"}
  end
end
