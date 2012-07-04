class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'layout'

  # application_controller.rb
  # filter_parameter_logging :password, :password_confirmation

  helper_method :current_user, :current_user_session

  before_filter :set_process_name_from_request
  def set_process_name_from_request
    $0 = "hdm*: " + request.path[0,20]
  end   

  after_filter :unset_process_name_from_request
  def unset_process_name_from_request
    $0 = "hdm_: " + request.path[0,20]
  end
  
  #before_filter :adjust_format_for_iphone

  private

  def adjust_format_for_iphone
    request.format = :iphone if iphone_request?
  end

  def iphone_request?
    #return (request.subdomains.first == "iphone" || params[:format] == "iphone")
    request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
  end


  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
