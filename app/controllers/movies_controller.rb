class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])  
    actor = Actor.find_actor(params[:name])
    if actor.present?
      @movie.actors << actor
      render :show
    end  
  end    
end