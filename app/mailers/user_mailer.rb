class UserMailer < Devise::Mailer
default from: "hello@festigo.es"
helper :application # gives access to all helpers defined within `application_helper`.
include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

def confirmation_instructions(record, token, opts={})
  global_admins = User.where('role = ?', :global_admin)
  global_admins.each do |admin_user|
    mail(to: admin_user.email, template_name: :'new_user_registered')
  end

  super
end

end
