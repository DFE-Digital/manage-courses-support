class CourseSerializer < ActiveModel::Serializer
  attributes :course_code, :modular, :study_mode
  has_many :sites
  has_one :provider

  def modular
    # TODO: pull in from UCAS, possible values "M" or nil
    nil
  end
end
