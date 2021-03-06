class UsersController < ApplicationController
  before_filter :require_user, :only => [:index, :show, :edit, :update, :destroy]
  # GET /users
  # GET /users.xml

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /users/1/critics
  def critics
    @user = User.find(params[:id])
    @critics = @user.critics.paginate(:per_page => 15, :page => params[:page])
    respond_to do |format|
      format.html # critics.html.erb
    end
  end
  
  # GET /users/1/mustsee
  def mustsee
    @user = User.find(params[:id])
    @movies = @user.mustsee.order('created_at DESC').paginate(:per_page => 25, :page => params[:page])
    respond_to do |format|
      format.html # critics.html.erb
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(root_url, :notice => 'Registration succesfull.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  # POST /users/1/add_to_list (?movie=9)
  def add_to_list
    @user = User.find(params[:id])
    @movie = Movie.find(params[:movie])
    @user.movies << @movie
    respond_to do |format|
      format.html { redirect_to(@movie, :notice => 'Movie was added to your wishlist.') }
      format.xml  { render :xml => @user }
    end
  end

  # POST /users/1/add_to_list (?movie=9)
  def remove_from_list
    @user = User.find(params[:id])
    @movie = Movie.find(params[:movie])
    @user.movies.delete(@movie)
    respond_to do |format|
      format.html { redirect_to(@movie, :notice => 'Movie was removed from your wishlist.') }
      format.xml  { render :xml => @user }
    end
  end

end
