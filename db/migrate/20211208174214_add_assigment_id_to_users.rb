class AddAssigmentIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :assigment_id, :integer
  end
end
