class ChargeMailer < ActionMailer::Base
  default from: "partybassics@gmail.com"
  layout 'email'
  add_template_helper(EventsHelper)

  def purchase_confirmation(purchase, event)
    @purchase = purchase
    @event = event
    @page = Page.find_by("controller LIKE ? and action LIKE ?", "mailers", "purchase_confirmation")
    @graphics = @page.get_graphics
    @page.graphics.each do |graphic|
      image_file = graphic.image.current_path.to_s
      attachments.inline[graphic.image.file.file] = File.read image_file
    end
    mail(to: @purchase.email, subject: @page.title)
  end
end
