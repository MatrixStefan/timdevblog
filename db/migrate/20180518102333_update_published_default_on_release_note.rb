class UpdatePublishedDefaultOnReleaseNote < ActiveRecord::Migration[5.2]
  def change
    change_column :release_notes, :published, :boolean, :default => false
  end
end
