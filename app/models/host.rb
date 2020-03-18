class Host < ApplicationRecord
  has_many :users
  has_many :patient_counts
  has_many :line_counts

  after_create :geocode
  after_validation :geocode

  geocoded_by :full_address

  def full_address
    [address_1, address_2, city, state].compact.join(",")
  end

  def google_maps_url
    "https://www.google.com/maps/place/#{full_address}/@#{latitude},#{longitude},17z"
  end

  def line_count_today
    @line_count_today ||= line_counts.where(created_at: [Time.now.beginning_of_day..Time.now.end_of_day]).sum(:amount)
  end

  def patient_count_today
    @patient_count_today ||= patient_counts.where(created_at: [Time.now.beginning_of_day..Time.now.end_of_day]).sum(:amount)
  end
end
