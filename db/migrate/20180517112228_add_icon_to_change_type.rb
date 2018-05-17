class AddIconToChangeType < ActiveRecord::Migration[5.2]
  def change
    rename_column :change_types, :change_type, :name
    add_column :change_types, :icon, :string
    add_column :change_types, :priority, :integer
  end
end
