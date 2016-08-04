class Select2Input < SimpleForm::Inputs::CollectionSelectInput
  def input_html_classes
    super.push('simple-form-select2')
  end
end
