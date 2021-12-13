class AddLastEditorIdToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :last_editor_id, :string
    add_column :news, :integer, :string
  end
end
