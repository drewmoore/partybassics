class ChargesController < ApplicationController
  def new
    @key = Rails.configuration.stripe[:publishable_key]
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.find(params["event-id"])
    @quantity = params[:quantity]
    @email = params[:email]

    customer = Stripe::Customer.create(
      :email => params[:email],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => params[:amount],
      :description => @event.title,
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to "/charges/new/#{@event.id}"
  end
end
