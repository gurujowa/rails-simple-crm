module ApplicationHelper
  def flash_notifications
    message = flash[:error] || flash[:notice]
    if (flash[:error].present?) 
      color = "error"
    else
      color = "alert"
    end
    
    if message
      type = flash.keys[0].to_s
      return javascript_tag "var n = noty({text: '" + message  + "', type: '" + color + "', timeout: 2000});"
    end
  end
end
