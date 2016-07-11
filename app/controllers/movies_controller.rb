class MoviesController < ApplicationController

def create
end

def index 
  @movies = Movie.all
end

end
