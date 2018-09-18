class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.includes(:institutions, :users).all
  end

  def index_without_active_users
    @organisations = Organisation.
      includes(:institutions, :users).
      left_outer_joins(:users).
      group('mc_organisation.id').
      having('count(mc_user.welcome_email_date_utc) = 0')

    render :index
  end
end
