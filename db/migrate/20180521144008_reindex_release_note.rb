class ReindexReleaseNote < ActiveRecord::Migration[5.2]
  def change
  end
  
  ReleaseNote.reindex
  
end
