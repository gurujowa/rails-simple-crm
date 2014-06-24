class DatetimePickerInput < SimpleForm::Inputs::Base
  def input
    @builder.text_field(attribute_name, input_options)
  end

  def input_options
    { :dateFormat => "yy/mm/dd HH:ii:ss", :class => "datetimepicker form-control"}
  end
end
