class AddCategoryFromLeadComment < ActiveRecord::Migration
  def change
    add_column :lead_comments, :category, :string, null: false, default: "jimu"
  end
end
