class ReleaseNote < ApplicationRecord
  searchkick
  
  has_many :release_note_items

  accepts_nested_attributes_for :release_note_items, allow_destroy: true, reject_if: :all_blank

  validates :release_date, :title, :presence => true

  scope :published, -> {where(published: true)}

  def search_data
    {
        title: title,
        intro: intro,
        outro: outro,
        release_date: release_date,

        #release_note_items (has_many)
        release_note_item_types: release_note_items.map{|rni| (rni.change_type.name)},
        release_note_item_titles: release_note_items.map(&:change_title),
        release_note_item_details: release_note_items.map(&:change_details)
    }
  end
  
end