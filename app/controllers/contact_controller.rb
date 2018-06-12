class ContactController < ApplicationController
  def new
  end

  def create
    p = params[:contact]
    # p.merge!(investor_source: 'Website', contact_type: 'BACOMM')
    # p.merge!(here: params[:hear_from])
    ZohoContact.save_contact(p)
    flash[:success] = 'Contact created successfully!'
    redirect_to root_path
  end

  def zoho_contact
  end
end
