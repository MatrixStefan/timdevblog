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

    begin
      if @release_note.save!
        respond_to do |format|
          flash[:notice] = 'Release Note created'
          format.html {redirect_to @release_note}
        end
      end
    rescue ActiveRecord::RecordInvalid => invalid
      respond_to do |format|
        format.html {render new_release_note_path}
      end
    end

  end

  def update
    release_note = set_release_note
    if release_note.update(release_note_params)
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
    release_note = set_release_note
    if release_note.published
      if release_note.update(published: false)
        respond_to do |format|
          flash[:notice] = 'Release Note unpublished'
          format.html {redirect_to :release_notes}
        end
      end
    else
      if release_note.update(published: true)
        respond_to do |format|
          flash[:notice] = 'Release Note published'
          format.html {redirect_to :release_notes}
        end
      end
    end
  end

  def tim_rn_signature
    'hbeue57uERSTGSG+5tyvagsrtAE%BYawg9uaethdgekvyioetS+RT_Wt85asghsiufunvgv5$%$%^4ihbcshjrvy5n$%^&*WDnsduvg93'
  end

  def notify
    release_note = set_release_note
    domain = (ENV['TIM_URL'] || 'http://0.0.0.0:3000')

    url = URI.parse(domain) + '/receive_webhooks'
    req = Net::HTTP::Post.new(url.request_uri, 'Content-Type' => 'application/json', 'x-tim-release-note' => tim_rn_signature)
    req.body = { origin: "TIM-Release-Notes", title: release_note.title, rnid: release_note.id}.to_json
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")
    response = http.request(req)


    #uri = URI(url)
    #req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', 'x-tim-release-note' => tim_rn_signature)
    #n

    puts "request #{req.body}"

    puts "response #{response.body}"

    respond_to do |format|
      flash[:notice] = 'Notification Sent'
      format.html {redirect_to :release_notes}
    end
  end
  
  private
  
  def set_release_note
    @release_note = ReleaseNote.find(params[:id])
  end

  def release_note_params
    params.require(:release_note).permit(:id, :user_id, :title, :intro, :outro, :release_date, :published,
                                         release_note_items_attributes: [:id, :user_id, :release_note_id, :change_type_id, :change_title, :change_details, :_destroy])
  end
end
