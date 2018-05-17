class ReleaseNoteItem < ApplicationRecord
  
  belongs_to :release_note
  belongs_to :change_type
  
end
