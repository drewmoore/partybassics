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

  private

  def contact_params
    params.require(:contact).permit(:email, :facebook_id, :facebook_link, :gender, :first_name, :last_name, :full_name)
  end
end
