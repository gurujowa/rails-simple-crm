class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
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
