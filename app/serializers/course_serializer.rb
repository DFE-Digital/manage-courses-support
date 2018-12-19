class CourseSerializer < ActiveModel::Serializer
  attributes :course_code, :start_month, :name, :study_mode, :copy_form_required, :profpost_flag, :program_type
  attributes :modular, :english, :maths, :science
  has_many :site_statuses, key: :campus_statuses
  has_many :subjects
  has_one :provider
  has_one :accrediting_provider

  def start_month
    object.start_date.iso8601 if object.start_date
  end

  def modular
    # TODO: pull in from UCAS, possible values "M" or nil
  end

  def copy_form_required
    "Y" # we want to always create PDFs for applications coming in
  end

  # TODO: add year parameter
end
