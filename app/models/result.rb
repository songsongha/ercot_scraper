class Result < ActiveRecord::Base
    belongs_to :prizes
    
    validates_presence_of :prizes
end
