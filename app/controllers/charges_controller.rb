class ChargesController < ApplicationController
  def new
    @key = Rails.configuration.stripe[:publishable_key]
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.find(params["event-id"])
    @quantity = params[:quantity]
    @email = params[:email]
    @amount = params[:amount]
    @lastfour = params[:lastfour]
    begin
      charge = Stripe::Charge.create(
        :amount      => @amount,
        :description => @event.title,
        :card  => params[:stripeToken],
        :currency    => 'usd'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to "/charges/new/#{@event.id}"
    end
  end
end
