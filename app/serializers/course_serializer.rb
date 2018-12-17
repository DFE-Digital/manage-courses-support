class CourseSerializer < ActiveModel::Serializer
  attributes :course_code, :start_month, :name, :study_mode, :copy_form_required, :profpost_flag, :program_type
  attributes :modular, :english, :maths, :science, :has_been_published
  has_many :site_statuses, key: :campus_statuses
  has_many :subjects
  has_one :provider
  has_one :accrediting_provider

  def start_month
    object.start_date
  end

  def modular
    # TODO: pull in from UCAS, possible values "M" or nil
  end

  def has_been_published
    # TODO: pull in from UCAS, possible values "M" or nil
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
