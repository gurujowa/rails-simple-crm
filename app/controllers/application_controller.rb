class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_noty type, text, add_javascript = nil
    noty_type = [:alert,:success,:error,:warning,:infomation,:confirm]
    raise  "notyのタイプに" + type.to_s + "は含まれていません" unless noty_type.include? type

    str = %Q{var n = noty({text: '#{text}', type: '#{type.to_s}', timeout: 1000});}
    render :text =>  str + add_javascript
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

  
    # Use callbacks to share common setup or constraints between actions.
    def check_user
      if session[:current_user] == nil
        redirect_to :controller => "users", :action=>"current"
      else
        @current_user = session[:current_user]
      end
    end

end
