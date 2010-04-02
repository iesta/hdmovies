class CriticsController < ApplicationController
  before_filter :require_user
  # GET /critics
  # GET /critics.xml
  def index
    @critics = Critic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @critics }
    end
  end

  # GET /critics/1
  # GET /critics/1.xml
  def show
    @critic = Critic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @critic }
    end
  end

  # GET /critics/new
  # GET /critics/new.xml
  def new
    @critic = Critic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @critic }
    end
  end

  # GET /critics/1/edit
  def edit
    @critic = Critic.find(params[:id])
  end

  # POST /critics
  # POST /critics.xml
  def create
    @critic = Critic.new(params[:critic])

    respond_to do |format|
      if @critic.save
        format.html { redirect_to(@critic, :notice => 'Critic was successfully created.') }
        format.xml  { render :xml => @critic, :status => :created, :location => @critic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @critic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /critics/1
  # PUT /critics/1.xml
  def update
    @critic = Critic.find(params[:id])

    respond_to do |format|
      if @critic.update_attributes(params[:critic])
        format.html { redirect_to(@critic, :notice => 'Critic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @critic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /critics/1
  # DELETE /critics/1.xml
  def destroy
    @critic = Critic.find(params[:id])
    @critic.destroy

    respond_to do |format|
      format.html { redirect_to(critics_url) }
      format.xml  { head :ok }
    end
  end
end
