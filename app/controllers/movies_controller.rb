require 'byebug'
require 'rubygems'
require 'nokogiri'  
require 'open-uri'

require 'openssl'

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# require_relative 'movie_stats'
class MoviesController < ApplicationController

  def index 
    @movies = Movie.all
  end

  def show 
    @movie = Movie.find(params[:id]) 
  end

  def search

  end

  def create
    @movie = Movie.create(movie_stats(movie_stringifier(params[:title])))
    redirect_to movie_path @movie
  end

  def thirties 
    @thirties_movies = Movie.where('date like ?', '%193%')
  end

  def aughts 
    @aughts_movies = Movie.where('date like ?', '%200%')
  end

# Movie.where('date like ?', '%201%')

  private 


  def movie_stringifier(string)
    string.split(" ").join("_")
  end

  def movie_params
    params.require(:movie).permit(:title)
  end

  def movie_stats(string)

    page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/#{string}"))

    title, director, length, box_office, ="", "", "", ""
    date, starring, budget, image = "", "", "", ""

    page.css("table.infobox.vevent tr").each_with_index do |table, i|

    if i==0
      title = table.to_s.split("</th>")[0].split(">")[-1]
    elsif table.to_s.nil? == false && table.to_s.include?("Directed by")
      director = table.to_s.split(">").select{|section|section.include?("/a")}[0][0..-4]
    elsif table.to_s.nil? == false && table.to_s.include?("Running time")
      length = table.to_s.split("minutes")[0].split(">")[-1] + "minutes"
    elsif table.to_s.nil? == false && table.to_s.include?("Box office")
      box_office = table.to_s.split("<").select{|section|section.include?("$")}.first.split(">")[1]
    elsif table.to_s.nil? == false && table.to_s.include?("Release date")
      date = table.to_s.split(">").select{|section|section.include?(",")}[0][0..-27]
    elsif table.to_s.nil? == false && table.to_s.include?("Starring")
      starring = table.to_s.split(">").select{|section|section.include?("/a")}.map {|actor| actor[0..-4]}
    elsif table.to_s.nil? == false && table.to_s.include?("Budget")
      budget = table.to_s.split("<").select{|section|section.include?("$")}.first.split(">")[1]
    elsif table.to_s.nil? == false && table.to_s.include?(".jpg")
      image = table.to_s.split("//")[1].split("width")[0][0..-3]
    end
    end

    movie_stats = {title: title, starring: starring, date: date, running_time: length, 
      director: director, box_office: box_office, budget: budget, image: image}

  end

end
