class CreateAssigments < ActiveRecord::Migration[6.1]
  def change
    create_table :assigments do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end
end
