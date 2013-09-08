# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Mycrm::Application.initialize!
Payday::Config.default.invoice_logo = '.\lib\payday\assets\logo.png'
Payday::Config.default.company_name = "ユアブライト株式会社"
Payday::Config.default.company_details = "東京都新宿区高田馬場３－３－９　山下ビル5F"