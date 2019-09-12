module OrganisationHelper
  def user_details(user, dfe_signin_deeplink: false)
    if dfe_signin_deeplink && user.sign_in_user_id.present?
      link_to "#{user.first_name} #{user.last_name} <#{user.email}>",
              dfe_signin_user_audit_link(user), class: 'govuk-link'
    else
      "#{user.first_name} #{user.last_name} <#{user.email}>"
    end
  end

  def provider_details(provider)
    link_to "#{provider.provider_name} [#{provider.provider_code}]",
            provider_url_on_publish_teacher_training_courses(provider), class: 'govuk-link'
  end

  def provider_url_on_publish_teacher_training_courses(provider)
    "#{Settings.manage_frontend.base_url}organisations/#{provider.provider_code.downcase}"
  end
end
