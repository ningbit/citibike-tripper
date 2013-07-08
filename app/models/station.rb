class Station < ActiveRecord::Base
  attr_accessible :availableBikes, :availableDocks, :last_updated, :latitude, :longitude, :name
end
