class EventsController < ApplicationController
  before_action :authenticate
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @sponsorship_events = Event.get_sponsorship_events(current_user.id)
    invited_events = Event.get_invited_events(current_user.id)
    @participateds_events = invited_events.select { |event| EventsHelper.is_join?(event.status) }
    @invited_events = invited_events.select { |event| EventsHelper.is_leave?(event.status) }
    @event = Search::Event.new
  end

  def search
    @event = Search::Event.new(search_params)
    @events = @event.matches
    @sponsorship_events = []
    invited_events = []

    @events.each do |e|
      sponsorship_events = Event.search_sponsorship_events(current_user.id, e.id)
      sponsorship_events.each do |sponsorship_event|
        @sponsorship_events.push(sponsorship_event)
      end
      participateds_events = Event.search_participateds_events(current_user.id, e.id)
      participateds_events.each do |participateds_event|
        invited_events.push(participateds_event)
      end
    end
    @participateds_events = invited_events.select { |event| EventsHelper.is_join?(event.status) }
    @invited_events = invited_events.select { |event| EventsHelper.is_leave?(event.status) }
  end

  def join
    @event = Event.find_by(id: params[:id])
    event_user = EventUser.get_one(current_user.id, @event.id)
    event_user.status = 1
    if event_user.save
      redirect_to(events_path)
    end
  end

  def leave
    @event = Event.find_by(id: params[:id])
    event_user = EventUser.get_one(current_user.id, @event.id)
    event_user.status = 0
    if event_user.save
      redirect_to(events_path)
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find_by(id: params[:id])
    @latitude = @event.latitude

    @longitude = @event.longitude

    @address = @event.address
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    unless EventUser.is_admin?(current_user.id, params[:id])
      redirect_to(events_path)
    end
  end

  # POST /events
  # POST /events.json
  def create
    # イベント作成者は管理者となる
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        # TODO もっと良い方法が確実にある
        events_user = EventUser.new(user_id: current_user.id, event_id: @event.id, admin: true)
        events_user.save
        format.html { redirect_to @event, notice: 'イベントを作成しました。' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    unless  EventUser.is_admin?(current_user.id, params[:id])
      redirect_to(events_path)
    end

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'イベントを更新しました。' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    unless EventUser.is_admin?(current_user.id, params[:id])
      redirect_to(events_path)
    end

    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'イベントを削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.fetch(:event, {}).permit(:image, :name, :event_date, :address, :location_name, :location_url, :capacity, :description, :link)
    end

    def search_params
      params
          .require(:search_event)
          .permit(Search::Event::ATTRIBUTES)
    end

    def authenticate
      redirect_to '/' unless user_signed_in?
    end
end
