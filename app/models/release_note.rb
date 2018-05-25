class ReleaseNote < ApplicationRecord
  searchkick
  
  has_many :release_note_items, :inverse_of => :release_note
  belongs_to :user

  accepts_nested_attributes_for :release_note_items, allow_destroy: true, reject_if: :all_blank

  validates :release_date, :title, :user_id, :presence => true

  scope :published, -> {where(published: true)}
  scope :bug_fixes, -> {where("id IN (SELECT release_note_id FROM release_note_items WHERE(change_type_id = (SELECT id FROM change_types WHERE (name = 'Bug Fix'))))")}
  scope :new_features, -> {where("id IN (SELECT release_note_id FROM release_note_items WHERE(change_type_id = (SELECT id FROM change_types WHERE (name = 'New Feature'))))")}
  scope :enhancements, -> {where("id IN (SELECT release_note_id FROM release_note_items WHERE(change_type_id = (SELECT id FROM change_types WHERE (name = 'Enhancement'))))")}

  def search_data
    {
        title: title,
        intro: intro,
        outro: outro,
        release_date: release_date,
        release_date_day: release_date.day,
        release_date_day_name: release_date.strftime("%A"),
        release_date_month: release_date.month,
        release_date_month_name: release_date.strftime("%B"),
        release_date_year: release_date.year,
        author_first_name: user.first_name,
        author_last_name: user.last_name,
        author_nickname: user.nickname,
        author_job_title: user.job_title,

        #release_note_items (has_many)
        release_note_item_types: release_note_items.map{|rni| (rni.change_type.name)},
        release_note_item_titles: release_note_items.map(&:change_title),
        release_note_item_details: release_note_items.map(&:change_details)
    }
  end
  
end