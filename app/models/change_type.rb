class ChangeType < ApplicationRecord

  has_many :release_note_items, :inverse_of => :change_type

  validates :name, :icon, presence: true
  validates :priority, presence: true, uniqueness: true
  
  def get_type(type)
    self.find(type)
  end

end