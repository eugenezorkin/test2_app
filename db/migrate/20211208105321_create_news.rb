class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.integer :author
      t.integer :number_edits

      t.timestamps
    end
  end
end
