class LeadselectInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    default = []
    if @builder.object.lead.present?
      lead_id = @builder.object.lead.id
      name = @builder.object.lead.name
      default = [[name,lead_id]]
    end
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:class] << "search_lead form-control"
    out = "#{@builder.select(attribute_name,default,{}, merged_input_options)}".html_safe
  end
end
