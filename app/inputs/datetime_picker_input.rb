class DatetimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:class] = "datetimepicker form-control"
    merged_input_options[:dateFormat] = "yy/mm/dd HH:ii:ss"
    merged_input_options[:value] = @builder.object.read_attribute(attribute_name) if merged_input_options[:value].blank?
    @builder.send(:text_field,attribute_name, merged_input_options)
  end

end
