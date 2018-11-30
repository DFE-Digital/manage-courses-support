class CourseSerializer < ActiveModel::Serializer
  attributes :course_code, :institution_code

  def institution_code
    object.provider.provider_code
  end
end
