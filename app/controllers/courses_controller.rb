class CoursesController < ActionController::API
  def index
    @courses = Course.all
    render json: @courses
  end
end
