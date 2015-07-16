class MapGroup < ActiveRecord::Base
	has_many :maps
    attr_accessible :identifier, :name
end
