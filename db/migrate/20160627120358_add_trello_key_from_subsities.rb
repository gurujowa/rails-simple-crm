class AddTrelloKeyFromSubsities < ActiveRecord::Migration
  def change
    add_column :subsities, :trello_board, :string
    add_column :subsities, :trello_list, :string
  end
end
