class ChargeMailer < ActionMailer::Base
  layout 'email'
  add_template_helper(EventsHelper)

  def purchase_confirmation(purchase, event)
    @purchase = purchase
    @event = event
    @layout = Page.find_by("controller LIKE ? and action LIKE ?", "mailers", "template")
    @page = Page.find_by("controller LIKE ? and action LIKE ?", "charge_mailers", "purchase_confirmation")
    @graphics = @layout.get_graphics
    @contents = @page.get_contents
    @layout_contents = @layout.get_contents
    @layout.graphics.each do |graphic|
      image_file = graphic.image.current_path.to_s
      attachments.inline[graphic.image.file.file] = File.read image_file
    end
    mail(to: @purchase.email, subject: @page.title, from: @layout_contents["contact-info-content-main-email"].text)
  end
end
