class AddPreferredNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :preferred_name, :integer, default: 0
  end
end
