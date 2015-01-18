class DropColumnSubjectsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :subjects
  end
end
