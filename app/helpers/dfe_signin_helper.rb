module DfeSigninHelper
  def dfe_signin_user_audit_link(user)
    "https://support.signin.education.gov.uk/users/#{user.sign_in_user_id}/audit"
  end

  def dfe_signin_email_search(email)
    "https://support.signin.education.gov.uk/users?criteria=#{email}"
  end
end
