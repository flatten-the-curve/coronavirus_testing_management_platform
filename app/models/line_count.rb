class LineCount < ApplicationRecord
  belongs_to :host
  belongs_to :patient_count, optional: true
end
