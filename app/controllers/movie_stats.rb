require 'byebug'
require 'rubygems'
require 'nokogiri'  
require 'open-uri'

require 'openssl'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE



def movie_stats(string)


    page = Nokogiri::HTML(open("https://en.wikipedia.org/#{string}"))

    title=""
    directed_by_string = ""
    running_time_string = ""
    box_office_string = ""
    production_company = ""
    release_dates = ""
    starring_string=""
    budget_string = ""
    image_string=""


    def director(string)
      section = string.split(">").select{|section|section.include?("/a")}
      section[0][0..-4]
    end

    def running_time(string)
      string.split("minutes")[0][-4..-1] + "minutes"
    end

    def dates(string)
      section = string.split(">").select{|section|section.include?(",")}
      section[0][0..-27]
    end

    def starring_array(string)
      section = string.split(">").select{|section|section.include?("/a")}
      section.map {|actor| actor[0..-4]}
    end

    def box_office(string)
      section = string.split("<").select{|section|section.include?("$")}
      section.first.split(">")[1]
    end

    def budget(string)
      section = string.split("<").select{|section|section.include?("$")}
      section.first.split(">")[1]
    end

    def image(string)
      string.split("//")[1].split("width")[0][0..-3]
    end

    columns=[]

    page.css("table.infobox.vevent tr").each_with_index do |table, i|
    if i==0
      title = table.to_s.split("</th>")[0].split(">")[-1]
    elsif table.to_s.nil? == false && table.to_s.include?("Directed by")
      directed_by_string = table.to_s.split(">").select{|section|section.include?("/a")}[0][0..-4]
    elsif table.to_s.nil? == false && table.to_s.include?("Running time")
      running_time_string = table.to_s.split("minutes")[0].split(">")[-1] + "minutes"
    elsif table.to_s.nil? == false && table.to_s.include?("Box office")
      box_office_string = table.to_s.split("<").select{|section|section.include?("$")}.first.split(">")[1]
    elsif table.to_s.nil? == false && table.to_s.include?("Release date")
      release_dates = table.to_s.split(">").select{|section|section.include?(",")}[0][0..-27]
    elsif table.to_s.nil? == false && table.to_s.include?("Starring")
      starring_string = table.to_s.split(">").select{|section|section.include?("/a")}.map {|actor| actor[0..-4]}
    elsif table.to_s.nil? == false && table.to_s.include?("Budget")
      budget_string = table.to_s.split("<").select{|section|section.include?("$")}.first.split(">")[1]
    elsif table.to_s.nil? == false && table.to_s.include?(".jpg")
      image_string = table.to_s.split("//")[1].split("width")[0][0..-3]
    end
    end

    starring = starring_string
    date = release_dates
    running_time = running_time_string 
    director = directed_by_string
    box_office = box_office_string
    budget = budget_string
    image = image_string

    movie_stats = {title: title, starring: starring, date: date, running_time: running_time, 
      director: director, box_office: box_office, budget: budget, image: image}

end

