class ReleaseNotesController < ApplicationController
  
  def new
  end

  def create
  end
  
  def show
    set_release_note
  end

  def edit
    set_release_note
  end

  def destroy
  end
  
  private
  
  def set_release_note
    @release_note = ReleaseNote.find(params[:id])
  end
end
