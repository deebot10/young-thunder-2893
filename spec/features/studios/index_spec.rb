require 'rails_helper'

RSpec.describe 'Studio Index' do
  before(:each) do
    @studio_1 = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @studio_2 = Studio.create!(name: 'Tyler Perry Studios', location: 'Atlanta')    

    @movie_1 = @studio_1.movies.create!(title: 'Raiders of the lost ARK', creation_year: 1981, genre: 'Action/Adventure')
    @movie_2 = @studio_2.movies.create!(title: 'Black Panther', creation_year: 2016, genre: 'Action')

    visit '/studios'
  end 
  
  # Story 1
  it 'Can display all studios and movies' do

    expect(page).to have_content(@studio_1.name)
    expect(page).to have_content(@studio_1.location)

    expect(page).to have_content(@studio_2.name)
    expect(page).to have_content(@studio_2.location)

    expect(page).to have_content(@movie_1.title)
    expect(page).to have_content(@movie_2.title)
  end
end