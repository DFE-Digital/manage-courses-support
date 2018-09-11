module OrganisationHelper
  def user_details(user)
    "#{user.first_name} #{user.last_name} <#{user.email}>"
  end

  def institution_details(institution)
    link_to "#{institution.inst_full} [#{institution.inst_code}]",
      institution_url_on_publish_teacher_training_courses(institution)
  end

  def institution_url_on_publish_teacher_training_courses(institution)
    "https://publish-teacher-training-courses.education.gov.uk/organisation/#{institution.inst_code.downcase}"
  end
end
