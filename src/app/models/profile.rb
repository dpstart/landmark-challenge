class Profile < ApplicationRecord
    has_many :has_visiteds
    has_many :landmarks, :through => :has_visiteds
    has_many :has_earneds
    has_many :achievements, :through => :has_earneds
    belongs_to :user
    validates :bio, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
    validates :user, presence: true
end
