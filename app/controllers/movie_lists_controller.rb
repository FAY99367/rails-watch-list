# frozen_string_literal: true en haut du fichier.

class MovieListsController < ApplicationController
  before_action :set_movie_list, only: [:show, :bookmark, :remove_bookmark]

  # Affiche toutes les listes de films
  def index
    @movie_lists = MovieList.all
  end

  # Affiche le formulaire de création d'une nouvelle liste
  def new
    @movie_list = MovieList.new
  end

  # Crée une nouvelle liste de films
  def create
    @movie_list = MovieList.new(movie_list_params)
    if @movie_list.save
      redirect_to @movie_list, notice: 'La liste de films a été créée avec succès.'
    else
      render :new
    end
  end

  # Affiche les détails d'une liste de films
  def show
    @movies = Movie.all
  end

  # Ajoute un film à une liste de films
  def bookmark
    @movie = Movie.find(params[:movie_id])
    unless @movie_list.movies.include?(@movie)
      @movie_list.movies << @movie
      redirect_to @movie_list, notice: 'Film ajouté à la liste.'
    else
      redirect_to @movie_list, alert: 'Le film est déjà dans la liste.'
    end
  end

  # Retire un film d'une liste de films
  def remove_bookmark
    @movie = Movie.find(params[:movie_id])
    if @movie_list.movies.include?(@movie)
      @movie_list.movies.delete(@movie)
      redirect_to @movie_list, notice: 'Film retiré de la liste.'
    else
      redirect_to @movie_list, alert: 'Le film n\'est pas dans la liste.'
    end
  end

  private

  # Trouve une liste de films par son ID
  def set_movie_list
    @movie_list = MovieList.find(params[:id])
  end

  # Paramètres autorisés pour une liste de films
  def movie_list_params
    params.require(:movie_list).permit(:name)
  end
end
