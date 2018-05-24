class ReleaseNoteItemsController < ApplicationController

  before_action :set_release_note_item, only: [:edit, :update, :destroy]

  def new
    @release_note_item = ReleaseNoteItem.new
  end

  def create
    @release_note_item = ReleaseNoteItem.new(release_note_item_params)
    @release_note_item.save!
  end

  def edit
  end

  def update
    @release_note_item.update(release_note_item_params)
  end

  def destroy
=begin
    @release_note_item.destroy
    respond_to do |format|
      format.html {render new_release_note_path}
      format.json {head :no_content}
    end
=end
  end
  
  private
  
  def set_release_note_item
    @release_note_item = ReleaseNoteItem.find(params[:id])
    puts 'Working on Release Note Item ' + @release_note_item.id.to_s
  end
  
  def release_note_item_params
    params.require(:release_note).permit(:id, :release_note_id, :change_type_id, :change_title, :change_details, :_destroy)
  end
  
end
