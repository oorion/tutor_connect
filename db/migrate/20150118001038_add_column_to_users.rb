class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :zipcode, :string
    add_column :users, :role, :string
    add_column :users, :subjects, :string
    add_column :users, :availability, :text
  end
end
