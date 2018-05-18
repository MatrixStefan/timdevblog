class ReleaseNote < ApplicationRecord
  
  has_many :release_note_items

  accepts_nested_attributes_for :release_note_items, allow_destroy: true, reject_if: :all_blank


  scope :published, -> {where(published: true)}
  
end