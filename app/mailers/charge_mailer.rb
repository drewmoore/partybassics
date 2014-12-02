class ChargeMailer < ActionMailer::Base
  default from: "partybassics@example.com"
  layout 'email'
  add_template_helper(EventsHelper)

  def purchase_confirmation(email, event, quantity, amount, lastfour)
    @email = email
    @event = event
    @quantity = quantity
    @amount = amount
    @lastfour = lastfour
    mail(to: @email, subject: "Ticket Confirmation from Party Bassics")
  end
end
