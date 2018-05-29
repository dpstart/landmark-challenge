class Achievement < ApplicationRecord
    has_many :has_earneds
    has_many :profiles, :through => :has_earneds
    validates :name, presence: true
end
