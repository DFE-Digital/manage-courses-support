class CourseSerializer < ActiveModel::Serializer
  attributes :course_code, :course_month, :name, :study_mode, :copy_form_required, :profpost_flag
  attributes :modular, :english, :maths, :science
  has_many :site_statuses, key: :campuses
  has_one :provider
  has_one :accrediting_provider

  def course_month
    object.start_date
  end

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

  def copy_form_required
    "Y" # we want to always create PDFs for applications coming in
  end
end
