class ContactsController < ApplicationController
  def create
    pre = Contact.find_by("email LIKE ?", contact_params[:email])
    if pre
      pre.update_attributes(contact_params)
    else
      @contact = Contact.new(contact_params)
      @contact.save
    end
    render nothing:true
  end

  def unsubscribe
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(contact_params)
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :facebook_id, :facebook_link, :gender, :first_name, :last_name, :full_name, :unsubscribed)
  end
end
