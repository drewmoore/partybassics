class PurchasesController < ApplicationController
  def index
    @events = Event.all
    @events.order! 'created_at DESC'
  end

  def event_purchases
    @event = Event.find(params[:id])
    @ticket_percentage = percent(@event.tickets_sold, @event.ticket_limit)
    @current_sales = @event.tickets_sold.to_f * @event.price.to_f
    @email_search_string = params[:email_search_string]
    @conf_search_string = params[:conf_search_string]
    @lastfour_search_string = params[:lastfour_search_string]
    if @email_search_string
      @purchases = @event.purchases.where("email LIKE ?", "%#{@email_search_string}%")
    elsif @conf_search_string
      @purchases = @event.purchases.where("conf_num LIKE ?", "%#{@conf_search_string}%")
    elsif @lastfour_search_string
      @purchases = @event.purchases.where("lastfour LIKE ?", "%#{@lastfour_search_string}%")
    else
      @purchases = @event.purchases
    end
    respond_to do |format|
      format.js
    end
  end
end
