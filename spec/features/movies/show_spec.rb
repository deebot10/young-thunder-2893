require 'rails_helper'

RSpec.describe 'Movie Show' do
  before(:each) do
    @studio = Studio.create!(name: 'Universal Studios', location: 'Hollywood') 

    @movie = @studio.movies.create!(title: 'Sound of Metal', creation_year: 2020, genre: 'Action')
    @movie_1 = @studio.movies.create!(title: 'The Dark Knight', creation_year: 2010)   

    @actor_1 = @movie.actors.create!(name: 'John Boyega', age: 27)
    @actor_2 = @movie.actors.create!(name: 'Samuel L Jackson', age: 81)
    @actor_3 = @movie.actors.create!(name: 'Lakeith Stanfield', age: 33)
    @actor_4 = @movie.actors.create!(name: "Lupita Nyong'o", age: 34) 

    visit "/movies/#{@movie.id}"
  end 
  
  # Story 2
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
  end
  
    # Story 3
    # Add an Actor to a Movie
    
    # As a user,
    # When I visit a movie show page,
    # I do not see any actors listed that are not part of the movie
    # And I see a form to add an actor to this movie
    # When I fill in the form with the name of an actor that exists in the database
    # And I click submit
    # Then I am redirected back to that movie's show page
    # And I see the actor's name is now listed
    # (You do not have to test for a sad path, for example if the name submitted is not an existing actor)
  it 'has a form to add a actor to a movie' do
    visit "/movies/#{@movie_1.id}"

    expect(page).to have_content(@actor_1.name)
    
    fill_in 'Actor Name', with: 'John Boyega'
    click_on('Submit')
    
    expect(page).to have_content(@actor_1.name)
  end
end