require 'byebug'
require 'rubygems'
require 'nokogiri'  
require 'open-uri'

require_relative '../../config/environment.rb'
require_relative 'movie_stats'


 require 'openssl'
   OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Academy_Award_for_Best_Picture"))


movie_urls=[]
movie_strings=[]
movies=[]

page.css("table.wikitable td i").each do |movie_string|
 movie_strings << movie_string.to_s
end

movie_strings.compact.map do |movie_string|
  string = movie_string.split("href=")[1]
  unless string == nil 
    movies << string.split("title=").first[2..-3]
  end
end

revised = movies.delete_if {|movie| movie.include?("class=")}


academy_awards_hashes = []


revised.each_with_index do |movie, i|
  if i < 510 && i > 505

    
   Movie.create(movie_stats(movie))

end
end




