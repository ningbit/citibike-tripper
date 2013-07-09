require 'open-uri'

class Station < ActiveRecord::Base
  attr_accessible :availableBikes, :availableDocks, :last_updated, :latitude, :longitude, :name

  def self.refresh
    Station.destroy_all
    json = open("http://citibikenyc.com/stations/json") {|f| f.read}
    if json.size == 0
      json = File.open("lib/assets/citibike_data.json")
    end
    data = MultiJson.load(json, :symbolize_keys => true)
    @@refresh_time = (data[:executionTime] + " -0400")
    data[:stationBeanList].each do |station|
      station_hash = Hash.new
      station_hash[:name] = station[:stationName]
      station_hash[:latitude] = station[:latitude]
      station_hash[:longitude] = station[:longitude]
      station_hash[:availableBikes] = station[:availableBikes]
      station_hash[:availableDocks] = station[:availableDocks]
      station_hash[:last_updated] = data[:executionTime] || "2013-07-08 23:54:34"
      Station.create(station_hash)
    end
  end

  def self.refresh_time
    @@refresh_time
  end

end
