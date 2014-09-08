class DatetimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    @builder.send(:text_field,attribute_name, input_options)
  end

  def input_options
    { :dateFormat => "yy/mm/dd HH:ii:ss", :class => "datetimepicker form-control", :value => @builder.object.read_attribute(attribute_name)}
  end
end
