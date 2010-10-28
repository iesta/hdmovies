class MoviesController < ApplicationController
  before_filter :require_user
  # GET /movies
  # GET /movies.xml
  def index
    if params[:s]
      @movies = Movie.where("title LIKE '\%#{params[:s]}\%'").order('created_at DESC').paginate :per_page => 20, :page => params[:page]
      @movies = Movie.where("alt_title LIKE '\%#{params[:s]}\%'").order('created_at DESC').paginate :per_page => 20, :page => params[:page] unless @movies.size>0
      @movies = Movie.where("\"cast\" LIKE '\%#{params[:s]}\%'").order('created_at DESC').paginate :per_page => 20, :page => params[:page] unless @movies.size>0
      @movies = Movie.where("\"director\" LIKE '\%#{params[:s]}\%'").order('created_at DESC').paginate :per_page => 20, :page => params[:page] unless @movies.size>0
    elsif params[:m]
      @movies = Movie.where("tvserie != ''").order('created_at DESC').paginate :per_page => 20, :page => params[:page]
    else
      if params[:order]
        case params[:order]
        when 'score'
          order = "imdb_score DESC"
        when 'title'
          order = "title ASC"
        end
        
      else
        order = "created_at DESC"
      end
      @movies = Movie.order(order).paginate :per_page => 20, :page => params[:page]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end
  
  def grid
    @movies = Movie.where("photo_file_name IS NOT NULL").order('created_at DESC').paginate :per_page => 16, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  def stats
    @movies_size = Movie.count
    @movies_w_pics_size = Movie.count(:conditions => "photo_file_name IS NOT NULL")
    @critics_size = Critic.count
    @users_size = User.count
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])

    respond_to do |format|
      if @movie.save
        format.html { redirect_to(@movie, :notice => 'Movie was successfully created.') }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to(@movie, :notice => 'Movie was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end
end
