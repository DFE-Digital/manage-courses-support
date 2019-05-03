# frozen_string_literal: true

class NctlOrganisation < ApplicationRecord
  self.table_name = 'nctl_organisation'
  self.primary_key = 'nctl_id'

  belongs_to :organisation
end
