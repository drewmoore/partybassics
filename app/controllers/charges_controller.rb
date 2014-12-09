class ChargesController < ApplicationController
  def new
    @event = Event.find(params[:id])
    ticket_diff = @event.ticket_limit.to_i - @event.tickets_sold.to_i
    if ticket_diff > 0
      @key = Rails.configuration.stripe[:publishable_key]
    else
      redirect_to "/events/sold-out/#{@event.id}"
    end
  end

  def create
    @event = Event.find(params["event-id"])
    @quantity = params[:quantity]
    @email = params[:email]
    @amount = params[:amount]
    @lastfour = params[:lastfour]

    Contact.create(email: @email)

    ticket_diff = @event.ticket_limit.to_i - @event.tickets_sold.to_i
    if @quantity.to_i <= ticket_diff
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
          @event.tickets_sold = ((@event.tickets_sold.to_i or 0) + @quantity.to_i).to_s
          @event.purchases << @purchase
          @event.save
          ChargeMailer.purchase_confirmation(@purchase, @event).deliver
        else
          flash[:error] = "The purchase could not be saved."
          redirect_to "/charges/new/#{@event.id}"
        end
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to "/charges/new/#{@event.id}"
      end
    else
      if ticket_diff > 0
        flash[:error] = "Sorry, but there are now only #{ticket_diff} ticket/s left."
        redirect_to "/charges/new/#{@event.id}"
      else
        flash[:error] = "Sorry, but the event has sold out."
        redirect_to "/events/sold-out/#{@event.id}"
      end
    end
  end

end
