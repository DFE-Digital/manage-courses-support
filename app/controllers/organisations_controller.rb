class OrganisationsController < ApplicationController
  def index
    @organisations = Organisation.includes(:institutions, :users).all
  end
end
