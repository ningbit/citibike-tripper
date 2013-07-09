require 'open-uri'

class Station < ActiveRecord::Base
  attr_accessible :availableBikes, :availableDocks, :last_updated, :latitude, :longitude, :name, :station_id

  def self.generate_station(stationList)
    stationList.each do |station|
      new_station = Hash.new
      new_station[:name] = station[:stationName]
      new_station[:latitude] = station[:latitude]
      new_station[:longitude] = station[:longitude]
      new_station[:availableBikes] = station[:availableBikes]
      new_station[:availableDocks] = station[:availableDocks]
      new_station[:station_id] = station[:id].to_i
      new_station[:last_updated] = @@refresh_time
      Station.create(new_station)
    end
  end

  def self.read_write_json(json)
    if json.size == 0
      json = File.open("lib/assets/citibike_data.json")
    else
      open("lib/assets/citibike_data.json", "wb") do |file|
        file.write(json)
      end
    end
    return MultiJson.load(json, :symbolize_keys => true)
  end

  # Generates station data from CitiBike JSON or locally cached file
  def self.refresh
    json = open("http://citibikenyc.com/stations/json") {|f| f.read}
    if json.size == 0 && Station.all.size > 0
      return
    else
      Station.destroy_all
      data = read_write_json(json)
      @@refresh_time = (data[:executionTime] + " -0400")
      generate_station(data[:stationBeanList])
    end
  end

  def self.refresh_time
    @@refresh_time ||= nil
  end

end
