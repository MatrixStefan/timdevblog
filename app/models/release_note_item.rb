class ReleaseNoteItem < ApplicationRecord
  
  belongs_to :release_note
  belongs_to :change_type

  validates :change_type_id, :change_title, :change_details, :presence => true
  
end
