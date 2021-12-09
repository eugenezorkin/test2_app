class AddDigestToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :digest, :integer
  end
end
