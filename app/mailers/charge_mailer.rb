class ChargeMailer < ActionMailer::Base
  default from: "partybassics@partybassics.com"
  layout 'email'
  add_template_helper(EventsHelper)

  def purchase_confirmation(purchase, event)
    @purchase = purchase
    @event = event

    #attachments.inline["logo-dark-email.png"] = File.read("/data/ruby/partybassics/app/assets/images/logo-dark-email.png")

    mail(to: @purchase.email, subject: "Ticket Confirmation from Party Bassics")
  end
end
