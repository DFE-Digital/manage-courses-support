class CourseSerializer < ActiveModel::Serializer
  attributes :course_code, :name, :modular, :study_mode
  has_many :site_statuses, key: :campuses
  has_one :provider
  has_one :accrediting_provider

  def modular
    # TODO: pull in from UCAS, possible values "M" or nil
    nil
  end
end
