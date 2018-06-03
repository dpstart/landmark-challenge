class HasVisited < ApplicationRecord
    belongs_to :landmark
    belongs_to :profile
    validates :profile, :uniqueness => { :scope => :landmark}
end
