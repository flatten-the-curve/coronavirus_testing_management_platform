class PatientCount < ApplicationRecord
  belongs_to :host
  has_one :line_count
end
