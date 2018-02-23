module ApplicationHelper
  def flash_msg_name(name)
    new_name =
      case name
      when 'notice'
        'success'
      when 'alert'
        'danger'
      else
        name
      end
  end

  # Added by Tejaswini Patil on 19 Feb 2018
  # To add validation error messages below each field
  def show_errors(object, field_name)
  if object.errors.any?
    if !object.errors.messages[field_name].blank?
      object.errors.messages[field_name].join(", ")
    end
  end
end 
end
