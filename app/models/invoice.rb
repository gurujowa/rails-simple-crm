class Invoice < ActiveRecord::Base
  include Payday::Invoiceable
  
  has_many :line_items
end