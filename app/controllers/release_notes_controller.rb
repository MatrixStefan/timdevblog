class ReleaseNotesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @release_notes = ReleaseNote.all
  end
  
  def new
    @release_note = ReleaseNote.new
    @release_note.release_note_items.build
  end

  def create
    @release_note = ReleaseNote.new(release_note_params)
    if @release_note.save!
      respond_to do |format|
        flash[:notice] = 'Release Note created'
        format.html {redirect_to @release_note}
      end
    end
  end

  def update
    set_release_note
    if @release_note.update(release_note_params)
      respond_to do |format|
        flash[:notice] = 'Release Note updated'
        format.html {redirect_to @release_note}
      end
    end
  end
  
  def show
    set_release_note
  end

  def edit
    set_release_note
  end

  def destroy
  end

  def publish_toggle
    set_release_note
    if @release_note.published
      if @release_note.update(published: false)
        respond_to do |format|
          flash[:notice] = 'Release Note unpublished'
          format.html {redirect_to :release_notes}
        end
      end
    else
      if @release_note.update(published: true)
        respond_to do |format|
          flash[:notice] = 'Release Note published'
          format.html {redirect_to :release_notes}
        end
      end
    end
  end
  
  private
  
  def set_release_note
    @release_note = ReleaseNote.find(params[:id])
  end

  def release_note_params
    params.require(:release_note).permit(:id, :title, :intro, :outro, :release_date, :published,
                                         release_note_items_attributes: [:id, :release_note_id, :change_type_id, :change_title, :change_details, :_destroy])
  end
end
