class SearchController < ApplicationController
  def index
    if params[:query].start_with?('#')
      query  = params[:query].gsub('#', '')
      @posts = Tweet.joins(:hash_tags).where(hash_tags: {name:    query})
    else
      @posts = Tweet.where("post like ?", "%#{params[:query]}%")
    end
  end
end
