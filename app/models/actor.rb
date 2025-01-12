class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies 

  def self.actor_age
    order(:age)  
  end

  def self.average_age
    average(:age)
  end

  def self.find_actor(name)
    where("name = '#{name}'")
  end
end