class EventsController < ApplicationController
  def index
    @events = Event.all.where(hide: false)
    @events.order! 'created_at DESC'
  end

  def archive
    @events = Event.all.where(hide: true)
    @events.order! 'created_at DESC'
    render "index"
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.date = convert_date
    if @event.save
      flash[:notice] = "Event '#{@event.title}' has been set for #{@event.date} at #{@event.time}."
      redirect_to events_path
    else
      render "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.date = convert_date
    if @event.update_attributes(event_params)
      flash[:notice] = "Event has been updated."
      redirect_to events_path
    else
      render "edit"
    end
  end

  def hide
    @event = Event.find(params[:id])
    @event.update_attributes({hide: true})
    flash[:notice] = "#{@event.title} is now history. It's records are still on file under the events menu: archive."
    redirect_to events_path
  end

  def show
    @event = Event.find(params[:id])
    @event.update_attributes({hide: false})
    flash[:notice] = "#{@event.title} is now back on display."
    redirect_to events_path
  end

  def destroy
    @event = Event.find(params[:id])
    date = @event.date
    title = @event.title
    @event.destroy
    redirect_to events_path, :notice => "The event '#{title}' on #{date} has been deleted."
  end

  def display
    all_events = Event.all.where(hide: false)
    @events = all_events.sort_by do |e|
      datestring = ""
      datearray = e.date.split("-")
      datearray.each do |number|
        if number.length == 1
          number.prepend "0"
        end
      end
      year = datearray[0]
      month = datearray[1]
      day = datearray[2]
      datestring << year << month << day
    end
    @current_event = get_current_event
    respond_to do |format|
      format.js
    end
  end

  def display_one
    @event = Event.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def sold_out
    @event = Event.find(params[:id])
  end

  def fb_promote
    @contacts = Contact.where(unfacebooked: false)
  end

  private

  def get_current_event
    today = DateTime.now
    @events.each do |event|
      year = event.date.split("-")[0].to_i
      month = event.date.split("-")[1].to_i
      day = event.date.split("-")[2].to_i
      event_date = DateTime.new(year, month, day)
        if event_date >= today
          @current_event ||= event
        end
    end
    @current_event ||= @events.last
  end

  def convert_date
    year = params[:event]["date(1i)"]
    month = params[:event]["date(2i)"]
    day = params[:event]["date(3i)"]
    date = year.concat("-").concat(month).concat("-").concat(day)
  end

  def event_params
    params.require(:event).permit(
      :title, :time, :flyer, :facebook_id, :description, :venue, :city,
      :street, :zip, :price, :ticket_limit, :eventbrite_link)
  end

end
