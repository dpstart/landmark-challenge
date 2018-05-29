class City < ApplicationRecord
    has_many :landmarks
    validates :name, :country, presence: true

end
