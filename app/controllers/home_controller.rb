class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    url = URI("https://yts-am-torrent.p.rapidapi.com/list_movies.json")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = 'a4445c4fe6msheed0165a2a2e8d3p1057c5jsn18d92fd112d9'
    request["x-rapidapi-host"] = 'yts-am-torrent.p.rapidapi.com'

    response = http.request(request)
    @yts = response.read_body
  end

  def show
    require 'tvmaze'
    require 'net/http'
    require 'json'
    if params[:id] 
      id = params[:id]
      showurl = "http://api.tvmaze.com/shows/#{id}"
      casturl = "http://api.tvmaze.com/shows/#{id}/cast"
      seasonurl = "http://api.tvmaze.com/shows/#{id}/seasons"
      showuri = URI(showurl)
      casturi = URI(casturl)
      seasonuri = URI(seasonurl)
      responce = Net::HTTP.get(showuri)
      responce1 = Net::HTTP.get(casturi)
      responce2 = Net::HTTP.get(seasonuri)
      @output = JSON.parse(responce)
      @cast = JSON.parse(responce1)
      @season = JSON.parse(responce2)
    end
  end
  
  
  def terms
  end

  def privacy
  end

  def search
    require 'tvmaze'
    require 'net/http'
    require 'json'
    if params[:search] 
      name = params[:search]
      url = "http://api.tvmaze.com/search/shows?q=#{name}"
      uri = URI(url)
      responce = Net::HTTP.get(uri)
      result = JSON.parse(responce)
      @output= result.first(6)
      respond_to do |format|
        format.js {render partial: 'shared/result'}
      end
    end
  end
end
