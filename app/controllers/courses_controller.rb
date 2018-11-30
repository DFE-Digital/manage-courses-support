class CoursesController < ActionController::API
  def index
    @courses = Course.all.includes(:sites, :provider)
    render json: @courses
  end
end
