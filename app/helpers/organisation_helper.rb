module OrganisationHelper
  def user_details(user, dfe_signin_deeplink: false)
    if dfe_signin_deeplink && user.sign_in_user_id.present?
      link_to "#{user.first_name} #{user.last_name} <#{user.email}>",
        "https://support.signin.education.gov.uk/users/#{user.sign_in_user_id}/audit"
    else
      "#{user.first_name} #{user.last_name} <#{user.email}>"
    end
  end

  def institution_details(institution)
    link_to "#{institution.inst_full} [#{institution.inst_code}]",
      institution_url_on_publish_teacher_training_courses(institution)
  end

  def institution_url_on_publish_teacher_training_courses(institution)
    "https://publish-teacher-training-courses.education.gov.uk/organisation/#{institution.inst_code.downcase}"
  end
end
