class ReleaseNoteItem < ApplicationRecord
  
  belongs_to :release_note
  belongs_to :change_type
  belongs_to :user

  validates :change_type, :change_title, :change_details, :user, :release_note, :presence => true
  
end
