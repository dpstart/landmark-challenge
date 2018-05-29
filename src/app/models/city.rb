class City < ApplicationRecord
    has_many :landmarks
    validates :name, :country, presence: true
    validates :name, uniqueness: true

end
