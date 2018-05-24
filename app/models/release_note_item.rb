class ReleaseNoteItem < ApplicationRecord
  
  belongs_to :release_note
  belongs_to :change_type
  belongs_to :user

  validates :change_type_id, :change_title, :change_details, :user_id, :release_note_id, :presence => true
  
end
