class CoursesController < ActionController::API
  def index
    @courses = Course.all.includes(:sites, :provider, :site_statuses)
    paginate json: @courses
  end
end
