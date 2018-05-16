class CreateReleaseNoteItems < ActiveRecord::Migration[5.2]
  def change
    create_table :release_note_items do |t|
      t.integer :user_id
      t.integer :release_note_id
      t.string :change_type
      t.string :change_title
      t.text :change_details

      t.timestamps
    end
  end
end
