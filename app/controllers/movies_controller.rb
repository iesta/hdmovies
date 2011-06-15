class MoviesController < ApplicationController
  before_filter :require_user, :except => [:index]
  before_filter(:only => :index) do |controller|
    controller.send(:require_user) unless (controller.request.format.rss? || controller.request.format.json?)
  end
  
  respond_to :html
  
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
        when 'year'
          order = "year DESC"
        when 'average'
          order = "average_score DESC"
        end
      else
        order = "created_at DESC"
      end
      if params[:genre]
        @movies = Movie.tagged_with(params[:genre]).order(order).paginate(:per_page => 20, :page => params[:page]) unless @movies
      else
        @movies = Movie.order(order).paginate(:per_page => 20, :page => params[:page]) unless @movies
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.iphone # index.iphone.erb
      format.rss { render :layout => false } #index.rss.builder
      format.json { render_for_api :base, :json => @movies }
      format.xml { render_for_api :base, :xml => @movies, :root => :movies }
    end
  end
  
  def grid
    @movies = Movie.where("photo_file_name IS NOT NULL").order('created_at DESC').paginate :per_page => 16, :page => params[:page]
  end
  
  def sgrid
    @movies = Movie.where("photo_file_name IS NOT NULL").order('created_at DESC').paginate :per_page => 40, :page => params[:page]
  end

  def full
    @movies = Movie.order('title ASC')
  end
  
  def year
    if params[:id]
      @movies = Movie.where(["year = ?", params[:id].to_i]).order('year DESC,created_at DESC')
    else
      @movies = Movie.where("year IS NOT NULL").order('year DESC,created_at DESC')
    end
  end
  
  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.iphone #{ render :layout => false } # show.iphone.erb
      format.xml  { render :xml => @movie }
      format.json { render_for_api :base, :json => @movie }
      format.xml { render_for_api :base, :xml => @movie }
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
  
  # try to get data from freebase and redirect to edit with some fields filled
  # save still needs to be done
  # GET /movies/1/freebase?freebase_slug=
  def freebase
    require 'net/http'
    begin
      @movie = Movie.find(params[:id])
      
      # if we get a slug, we update the row
      if params[:freebase_slug]
        @movie.update_attribute('freebase', params[:freebase_slug])
      end
      
      # TODO : put that in model
      url = 'http://www.freebase.com/experimental/topic/standard' + @movie.freebase
      resp = Net::HTTP.get_response( URI.parse(url) )
      json = JSON.parse(resp.body)
      @result = json['result']
      raise unless @result

      # see example of json to parse : http://www.freebase.com/experimental/topic/standard/m/09k56b7
      @movie.alt_title = @result['text']
      @movie.country = @result['properties']['/film/film/country']['values'][0]['text']
      @movie.body = @result['description']
      @movie.genre_list = @result['properties']['/film/film/genre']['values'].map{|g| g['text']} #.join(',')
      @movie.year = @result['properties']['/film/film/initial_release_date']['values'][0]['value'].split('-')[0]
      @movie.director = @result['properties']['/film/film/directed_by']['values'].map{|g| g['text']}.join(', ')
      @movie.cast = @result['properties']['/film/film/starring']['values'].map{|g| g['text'].split('-')[0].rstrip}.join(', ')
      
      @result['webpage'].each{|p|
        @movie.url_imdb = p['url'] if p['text'] == 'IMDB Title Page'
        @movie.apple_url = p['url'] if p['url'] =~ /trailers\.apple\.com/i
        @movie.youtube_url = p['url'] if p['text'] =~ /youtube/i
        @movie.wikipedia_url = p['url'] if p['text'] == 'Wikipedia'
      }

      if params[:save]=='true'
        @movie.save
        redirect_to(@movie, :notice => 'Data updated with ' + url)
        return
      end
      
=begin
      if @movie.freebase
        # its way better to have the code
        slug = '/m/' + @movie.freebase.split('/').last
      else
        slug = '/en/' + @movie.title.rstrip.gsub(/\s/,'_').downcase
      end
      @resource = Ken.get(slug)
      raise if @resource.nil?
      @movie.director = @resource.attribute('/film/film/directed_by') unless @movie.director
      @movie.year = @resource.attribute('/film/film/initial_release_date').to_s.split('-').first
      @movie.country = @resource.attribute('/film/film/country').to_s.split(/\n/).first
      @movie.plot = @resource.attribute('/film/film/tagline')
      
      puts @resource.attribute('/film/film/initial_release_date').to_s.split('-').first
      puts @resource.attribute('/film/film/country')
      puts @resource.attribute('/film/film/tagline')
      #render 'edit'
=end
    #rescue
    #  redirect_to(@movie, :notice => 'No data found on Freebase, you could change freebase code : ' + @movie.freebase)
    end  
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
  
  # some basic stats
  def stats
    @movies_size = Movie.count
    @movies_w_pics_size = Movie.count(:conditions => "photo_file_name IS NOT NULL")
    @critics_size = Critic.count
    @users_size = User.count
  end
end

