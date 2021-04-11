class Prize < ActiveRecord::Base
    has_one :results
    has_many :maxmillions

    validates :date, uniqueness: true
end
