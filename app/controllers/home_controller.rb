class HomeController < ApplicationController
  def index
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
