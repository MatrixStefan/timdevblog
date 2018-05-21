class SearchController < ApplicationController
  def search
    if params[:term].nil?
      @release_notes = ReleaseNote.all
      respond_to do |format|
        flash[:notice] = 'No search results found. Displaying everything...'
        format.html {redirect_to :release_notes}
      end
    else
      @search_results = ReleaseNote.search(params[:term], order: {release_date: :desc})

      if @search_results.count == 0
        @release_notes = ReleaseNote.all
        respond_to do |format|
          flash[:notice] = 'No search results found. Displaying everything...'
          format.html {redirect_to :release_notes}
        end
      else
        flash[:notice] = 'We found ' + @search_results.count.to_s + ' results in ' + ((@search_results.took/1000).to_f).to_s + ' seconds'
      end
    end
  end
end
