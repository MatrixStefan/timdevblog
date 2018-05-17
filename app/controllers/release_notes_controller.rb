class ReleaseNotesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]

  def index
    @release_notes = ReleaseNote.all
  end
  
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
