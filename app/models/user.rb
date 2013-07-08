class User < ActiveRecord::Base
  attr_accessible :cell_number, :email, :first_name, :home_station, :last_name, :twitter, :work_station
end
