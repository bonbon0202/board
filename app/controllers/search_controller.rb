class SearchController < ApplicationController
  def result
    if params[:category] == "1"
      @contents =Post.where("title LIKE ?", "%#{params[:search_text]}%")
    elsif params[:category] == "2"
      @contents =Post.where("writer LIKE ?", params[:search_text])
    end    
  end
end
