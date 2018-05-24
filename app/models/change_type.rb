class ChangeType < ApplicationRecord

  has_many :release_note_items

  validates :name, :icon, presence: true
  validates :priority, presence: true, uniqueness: true

end