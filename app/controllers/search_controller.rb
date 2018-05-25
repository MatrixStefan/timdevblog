class SearchController < ApplicationController
  def search

    if params[:term].nil?
      @release_notes = ReleaseNote.all
      respond_to do |format|
        flash[:notice] = 'No search results found. Displaying everything...'
        format.html {redirect_to :release_notes}
      end
    else
      result_count = 0
      @search_results = ReleaseNote.search(params[:term], order: {release_date: :desc, id: :desc}, highlight:{tag: "<strong>"})

      if user_signed_in?
        result_count = @search_results.count
      else
        @search_results.each do |sr|
          result_count += 1 if sr.published
        end
      end

      if result_count == 0
        @release_notes = ReleaseNote.all
        respond_to do |format|
          flash[:notice] = 'No search results found. Displaying everything...'
          format.html {redirect_to :release_notes}
        end
      else
        flash[:notice] = 'We found ' + result_count.to_s + ' results in ' + @search_results.took.to_s + ' milliseconds'
      end
    end
  end
end
