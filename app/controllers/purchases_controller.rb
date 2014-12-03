class PurchasesController < ApplicationController
  def index
    @events = Event.all
    @events.order! 'created_at DESC'
  end

  def event_purchases
    @event = Event.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end
