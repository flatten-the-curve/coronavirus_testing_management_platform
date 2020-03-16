class Host < ApplicationRecord
  has_many :users
  has_many :patient_counts

  after_validation :geocode

  geocoded_by :full_address

  def full_address
    [address_1, address_2, state, zipcode].compact.join(",")
  end

end
