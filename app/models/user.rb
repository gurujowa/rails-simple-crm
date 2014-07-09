# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  def color
    num = self.id.modulo(9)
    case num
    when 1 then
      "background-color:Beige;"
    when 2 then
      "background-color:LightCyan;"
    when 3 then
      "background-color:LightPink;"
    when 4 then
      "background-color:Wheat;"
    when 5 then
      "background-color:PeachPuff;"
    when 7 then
      "background-color:PaleTurquoise;"
    when 8 then
      "background-color:Goldenrod;"
    when 9 then
      "background-color:Azure;"
    else
      raise "id modulo error"
    end
  end
end
