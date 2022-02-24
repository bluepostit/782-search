class MoviesController < ApplicationController
  def index
    if params[:query].present?
      query = <<-SQL
      title @@ :search_term
      OR synopsis @@ :search_term
      OR directors.first_name @@ :search_term
      OR directors.last_name @@ :search_term
      SQL
      @movies = Movie.joins(:director).where(query, search_term: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end
end
