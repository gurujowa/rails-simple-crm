class TimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    @builder.text_field(attribute_name, input_options)
  end

  def input_options
    val = @builder.object.read_attribute(attribute_name).strftime("%H:%M") if @builder.object.read_attribute(attribute_name).present?
    { :dateFormat => "HH:ii", :class => "timepicker form-control", value: val}
  end
end
