class LeadselectInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    id = @builder.object.id
    name = @builder.object.lead.name
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:class] << "search_lead"
    out = "#{@builder.select(attribute_name,[name,id],{}, merged_input_options)}".html_safe
  end
end
