class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_paper_trail_whodunnit


  def render_noty type, text, add_javascript = nil
    noty_type = [:alert,:success,:error,:warning,:infomation,:confirm]
    raise  "notyのタイプに" + type.to_s + "は含まれていません" unless noty_type.include? type

    str = %Q{var n = noty({text: '#{text}', type: '#{type.to_s}', timeout: 1000});console.log('#{text}');}
    if add_javascript.blank?
      render :text =>  str
    else
      render :text =>  str + add_javascript
    end
  end
  
  def remote_flag model
    @to = model.find(params[:id])
    @attr = params[:type]
    model_name = @to.class.name.underscore
    bool = !@to.read_attribute(@attr)
    @id = %Q{#{model_name}_#{@attr}_#{@to.id}}

    bool_locale = bool == true ? ".flag_on" : ".flag_off"
    @locale = "activerecord.flags." + model_name + "." + @attr + bool_locale

    if (@to.update_attributes({@attr => bool}))
      render :template => "js/flag"
    else
      render_noty :error, @to.errors.full_messages.to_s + "model_name = " + model_name
    end
  end

  protected
 
    def send_csv(csv, options = {})
      bom = "   "
      bom.setbyte(0, 0xEF)
      bom.setbyte(1, 0xBB)
      bom.setbyte(2, 0xBF)
      send_data csv.to_s.encode("Shift_JIS", invalid: :replace, undef: :replace, replace: "-"), options
    end
  
  private
  def reverse_bool(flag)
    if flag.equal?(true)
      return false
    elsif flag.equal?(false)
      return true
    else
      raise "型があっていません"
    end
  end

  
end
