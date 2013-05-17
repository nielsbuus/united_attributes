class Duck < ActiveRecord::Base
  extend UnitedAttributes::Model
  attr_accessible :birthday, :height, :name, :top_speed, :weight, :lifespan
  unite :height, :centimeter
  unite :top_speed, :meters_per_second
  unite :weight, :kilogram
  unite :lifespan, :day
end
