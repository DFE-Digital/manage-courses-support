class CoursesController < ActionController::API
  def index
    @courses = Course.all.includes(:sites)
    render json: @courses
  end
end
