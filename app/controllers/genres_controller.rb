class GenresController < ApplicationController
  before_filter :require_user, :only => [:index, :show, :edit, :update, :destroy]
  # GET /users
  # GET /users.xml
  def index
    @tags = Movie.tag_counts_on(:genre)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
end