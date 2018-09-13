class ReportsController < ApplicationController
  def show_organisations_engagement_report
    @report = OrganisationsEngagementReport.new.tap(&:run)
  end
end
