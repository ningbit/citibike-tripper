class Commute < ActiveRecord::Base
  attr_accessible :end, :end_time, :name, :start, :start_time, :user_id
end
