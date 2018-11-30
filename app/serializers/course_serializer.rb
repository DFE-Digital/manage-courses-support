class CourseSerializer < ActiveModel::Serializer
  attributes :course_code, :institution_code, :modular, :study_mode
  has_many :sites

  def institution_code
    object.provider.provider_code
  end

  def modular
    # TODO: pull in from UCAS, possible values "M" or nil
    nil
  end
end
