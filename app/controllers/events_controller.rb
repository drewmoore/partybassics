class EventsController < ApplicationController
  def index
    @events = Event.all
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

  def destroy
    @event = Event.find(params[:id])
    date = @event.date
    title = @event.title
    @event.destroy
    redirect_to events_path, :notice => "The event '#{title}' on #{date} has been deleted."
  end

  def display
    all_events = Event.all
    @events = all_events.sort_by do |e|
      datestring = ""
      datearray = e.date.split("-")
      year = datearray[0]
      month = datearray[1]
      day = datearray[2]
      datestring << year << month << day
    end
    @events.reverse!
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

  private

  def convert_date
    year = params[:event]["date(1i)"]
    month = params[:event]["date(2i)"]
    day = params[:event]["date(3i)"]
    date = year.concat("-").concat(month).concat("-").concat(day)
  end

  def event_params
    params.require(:event).permit(:title, :time, :flyer, :facebook_id, :description, :venue, :city, :street, :zip)
  end

end
