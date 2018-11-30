class CoursesController < ActionController::API
  def index
    @courses = Course.all.includes(:sites, :provider)
    paginate json: @courses
  end
end
