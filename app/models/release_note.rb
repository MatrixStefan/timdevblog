class ReleaseNote < ApplicationRecord
  searchkick
  
  has_many :release_note_items

  accepts_nested_attributes_for :release_note_items, allow_destroy: true, reject_if: :all_blank

  validates :release_date, :title, :presence => true

  scope :published, -> {where(published: true)}
  
end