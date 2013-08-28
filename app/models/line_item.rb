class LineItem < ActiveRecord::Base
  include Payday::LineItemable
  
  belongs_to :invoice
end