class Host < ApplicationRecord
  has_many :users
  has_many :patient_counts

  after_validation :geocode

  geocoded_by :full_address

  def full_address
    [address_1, address_2, city, state].compact.join(",")
  end

  def google_maps_url
    "https://www.google.com/maps/place/#{full_address}/@#{latitude},#{longitude},17z"
  end

end
