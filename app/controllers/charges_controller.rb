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

      @purchase = Purchase.new(quantity: @quantity, email: @email, amount: @amount, lastfour: @lastfour)
      if @purchase.save
        @purchase.conf_num = @purchase.id.hash
        @purchase.save
        @event.purchases << @purchase

        ChargeMailer.purchase_confirmation(@email, @event, @quantity, @amount, @lastfour).deliver

      else
        flash[:error] = "The purchase could not be saved."
        redirect_to "/charges/new/#{@event.id}"
      end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to "/charges/new/#{@event.id}"
    end
  end
end
