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

  def destroy
    @event = Event.find(params[:id])
    date = @event.date
    title = @event.title
    @event.destroy
    redirect_to events_path, :notice => "The event '#{title}' on #{date} has been deleted."
  end

  private

  def convert_date
    year = params[:event]["date(1i)"]
    month = params[:event]["date(2i)"]
    day = params[:event]["date(3i)"]
    date = year.concat("-").concat(month).concat("-").concat(day)
  end

  def event_params
    params.require(:event).permit(:title, :time, :flyer)
  end

end
