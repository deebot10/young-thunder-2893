require 'rails_helper'

RSpec.describe 'Movie Show' do
  before(:each) do
    @studio = Studio.create!(name: 'Universal Studios', location: 'Hollywood') 

    @movie = @studio.movies.create!(title: 'Sound of Metal', creation_year: 2020, genre: 'Action')
    # @movie_1 = @studio.movies.create!(title: 'The Dark Knight', creation_year: 2010)   

    @actor_1 = @movie.actors.create!(name: 'John Boyega', age: 27)
    @actor_2 = @movie.actors.create!(name: 'Samuel L Jackson', age: 81)
    @actor_3 = @movie.actors.create!(name: 'Lakeith Stanfield', age: 33)
    @actor_4 = @movie.actors.create!(name: "Lupita Nyong'o", age: 34) 

    visit "/movies/#{@movie.id}"
  end 
  
    # Story 2
    # Movie Show
    
    # As a user,
    # When I visit a movie's show page.
    # I see the movie's title, creation year, and genre,
    # and a list of all its actors from youngest to oldest.
    # And I see the average age of all of the movie's actors
  it 'shows a movie and its attributes' do

    expect(page).to have_content(@movie.title)
    expect(page).to have_content(@movie.creation_year)
    expect(page).to have_content(@movie.genre)
  end

  it 'shows the movies actors to youngest to oldest plus average age' do
    
    expect(@actor_1.name).to appear_before(@actor_3.name)
    expect(@actor_3.name).to appear_before(@actor_4.name)
    expect(@actor_4.name).to appear_before(@actor_2.name)
    expect(@actor_2.name).to_not appear_before(@actor_1.name)
    
    expect(page).to have_content('Average Age:43.75')
    save_and_open_page
  end
end