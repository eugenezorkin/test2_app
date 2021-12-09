class AddEditsNumberToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :edits_number, :integer
  end
end
