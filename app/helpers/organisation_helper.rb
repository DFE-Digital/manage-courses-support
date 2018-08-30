module OrganisationHelper
  def user_details(user)
    "#{user.first_name} #{user.last_name} <#{user.email}>"
  end

  def institution_details(institution)
    "#{institution.inst_full} [#{institution.inst_code}]"
  end
end
