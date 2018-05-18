class ReleaseNoteItemsController < ApplicationController
  def new
    @release_note_item = ReleaseNoteItem.new
  end

  def create
    @release_note_item = ReleaseNoteItem.new(release_note_item_params)
    @release_note_item.save!
  end

  def edit
    set_release_note_item
  end

  def update
    set_release_note_item
    @release_note_item.update(release_note_item_params)
  end

  def destroy
    set_release_note_item
    @release_note_item.destroy
  end
  
  private
  
  def set_release_note_item
    @release_note_item = ReleaseNoteItem.find(params[:id])
  end
  
  def release_note_item_params
    params.require(:release_note).permit(:id, :release_note_id, :change_type_id, :change_title, :change_details, :_destroy)
  end
  
end
