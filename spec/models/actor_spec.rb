require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it { should have_many(:actor_movies)}
    it { should have_many(:movies).through(:actor_movies)}    
  end    

  before(:each) do
    @studio = Studio.create!(name: 'Universal Studios', location: 'Hollywood') 

    @movie = @studio.movies.create!(title: 'Sound of Metal', creation_year: 2020, genre: 'Action')
    @movie_1 = @studio.movies.create!(title: 'The Dark Knight', creation_year: 2010)   

    @actor_1 = @movie.actors.create!(name: 'John Boyega', age: 27)
    @actor_2 = @movie.actors.create!(name: 'Samuel L Jackson', age: 81)
    @actor_3 = @movie.actors.create!(name: 'Lakeith Stanfield', age: 33)
    @actor_4 = @movie.actors.create!(name: "Lupita Nyong'o", age: 34) 
  end

  describe 'class methods' do
    it 'orders actors by age' do

      expect(Actor.actor_age).to eq([@actor_1, @actor_3, @actor_4, @actor_2])
    end

    it 'displays the average age of actors' do

      expect(Actor.average_age).to eq(0.4375e2)
    end

    it 'can find actors by name' do

      expect(Actor.find_actor(@actor_1.name)).to eq([@actor_1])
    end
  end
end