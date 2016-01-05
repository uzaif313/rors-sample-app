module SessionsHelper

  # login the user and Store the session information
  def log_in user
    session[:user_id]=user.id
  end

  #get the Current Login information
  def current_user
    @current_user||=User.find_by(id: session[:user_id])
  end

  #Check Wether the user login or not
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user=nil
  end


end
