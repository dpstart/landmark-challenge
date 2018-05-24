class Landmark < ApplicationRecord
    belongs_to :city
    has_many :has_visiteds
    has_many :profiles, :through => :has_visiteds
    validates :city, :name, uniqueness: true
    validates :latitude, :longitude, :name, :city, presence: true
end
