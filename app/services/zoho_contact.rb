class ZohoContact

  CONTACT_TYPE = 'bacomm'.freeze

  def self.save_contact(signup_params)

    email = signup_params[:email]
    first_name = signup_params[:first_name]
    last_name = signup_params[:last_name]
    phone = signup_params[:phone]
    # investor_source = signup_params[:investor_source]
    contact_type = CONTACT_TYPE
    description = signup_params[:description]
    # not_include = ["Where did you hear from us?"].freeze

    # hear_from = signup_params[:hear] unless not_include.include?(signup_params[:hear])
    begin
      # contact = RubyZoho::Crm::Contact.new(contactcf7: hear_from, email: email, first_name: first_name, last_name: last_name, phone: phone, lead_source: investor_source, contactcf5: contact_type, description: description)

      contact = RubyZoho::Crm::Contact.new(email: email, first_name: first_name, last_name: last_name, phone: phone, description: description, contact_type: contact_type)

      contact.save
    rescue => error
      Rails.logger.error "Something Went Wrong while Saving Newsletter Details for Email: #{email}, Exception: #{error}"
      false
    end

  end
end