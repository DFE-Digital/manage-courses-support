class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.includes(:providers, :userdbs).all
  end

  def index_without_active_users
    @organisations = Organisation.
      includes(:providers, :userdbs).
      left_outer_joins(:userdbs).
      group('organisation.id').
      having('count("user".welcome_email_date_utc) = 0')

    render :index
  end
end
