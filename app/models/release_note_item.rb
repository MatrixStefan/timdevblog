class ReleaseNoteItem < ApplicationRecord
  
  belongs_to :release_note
  belongs_to :change_type
  belongs_to :user

  validates :change_type, :change_title, :change_details, :user, :release_note, :presence => true

  scope :bug_fix, -> {where("change_type_id IN (SELECT id FROM change_types WHERE (name = 'Bug Fix'))")}
  scope :new_feature, -> {where("change_type_id IN (SELECT id FROM change_types WHERE (name = 'New Feature'))")}
  scope :enhancement, -> {where("change_type_id IN (SELECT id FROM change_types WHERE (name = 'Enhancement'))")}

end
