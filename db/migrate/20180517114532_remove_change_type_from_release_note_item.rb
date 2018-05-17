class RemoveChangeTypeFromReleaseNoteItem < ActiveRecord::Migration[5.2]
  def change
    remove_column :release_note_items, :change_type
    add_column :release_note_items, :change_type_id, :integer
  end
end
