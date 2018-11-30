class CourseSerializer < ActiveModel::Serializer
  attributes :course_code, :name, :study_mode
  attributes :modular, :english, :maths, :science
  has_many :site_statuses, key: :campuses
  has_one :provider
  has_one :accrediting_provider

  def modular
    # TODO: pull in from UCAS, possible values "M" or nil
    nil
  end

  def english
    # TODO: pull in from UCAS, possible values 1, 2, 3 or 9
  end

  def maths
    # TODO: pull in from UCAS, possible values 1, 2, 3 or 9
  end

  def science
    # TODO: pull in from UCAS, possible values 1, 2, 3 or 9
  end
end
