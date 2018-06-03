class HasEarned < ApplicationRecord
    belongs_to :profile
    belongs_to :achievement
    validates :profile, :uniqueness => { :scope => :achievement}
end
