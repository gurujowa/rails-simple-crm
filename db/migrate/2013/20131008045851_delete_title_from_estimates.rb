class DeleteTitleFromEstimates < ActiveRecord::Migration
  def change
    remove_column :estimates, :title
  end
end
