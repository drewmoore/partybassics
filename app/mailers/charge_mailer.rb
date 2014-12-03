class ChargeMailer < ActionMailer::Base
  default from: "partybassics@partybassics.com"
  layout 'email'
  add_template_helper(EventsHelper)

  def purchase_confirmation(purchase, event)
    @purchase = purchase
    @event = event
    mail(to: @purchase.email, subject: "Ticket Confirmation from Party Bassics")
  end
end
