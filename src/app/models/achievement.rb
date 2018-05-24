class Achievement < ApplicationRecord
    has_many :has_earneds
    has_many :profiles, :through => :has_earneds
    validates :color, inclusion {in: %w(gold, silver, bronze), message: "%{value} is not a valid size"}
    validates :name, presence: true
end
