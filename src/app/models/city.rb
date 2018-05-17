class City < ApplicationRecord
    has_many :landmarks
    validates :name, presence: true
end
