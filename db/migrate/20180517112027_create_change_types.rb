class CreateChangeTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :change_types do |t|
      t.string :change_type

      t.timestamps
    end
  end
end
