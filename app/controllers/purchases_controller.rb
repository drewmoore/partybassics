class PurchasesController < ApplicationController
  def index
    @events = Event.all
    @events.order! 'created_at DESC'
  end

  def event_purchases
    @event = Event.find(params[:id])
    @email_search_string = params[:email_search_string]
    @conf_search_string = params[:conf_search_string]
    if @email_search_string
      @purchases = @event.purchases.where("email LIKE ?", "%#{@email_search_string}%")
    elsif @conf_search_string
      @purchases = @event.purchases.where("conf_num LIKE ?", "%#{@conf_search_string}%")
    else
      @purchases = @event.purchases
    end
    respond_to do |format|
      format.js
    end
  end
end
