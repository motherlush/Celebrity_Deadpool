class AddFacebookFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email, :string
    add_column :users, :token, :string
    add_column :users, :name, :string
    add_column :users, :image, :string

    add_index :users, :email, unique: true
    add_index :users, :token, unique: true
  end
end
