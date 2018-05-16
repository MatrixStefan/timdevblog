class CreateReleaseNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :release_notes do |t|
      t.integer :user_id
      t.date :release_date
      t.string :title
      t.text :intro
      t.text :outro
      t.boolean :published

      t.timestamps
    end
  end
end
