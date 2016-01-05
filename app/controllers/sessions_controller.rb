class SessionsController < ApplicationController

  def new

  end

  def create
    # render json:params[:sessions][:email]+" "+params[:sessions][:password]
    # render json:
    #render "new"
    # render  json:user.to_yaml

    user = User.find_by(email:params[:sessions][:email])

    if user && user.authenticate(params[:sessions][:password])
      # Do the Login Successfully
      log_in user
      redirect_to user
    else
      #Login Faild Redirect User to Login page with Flash Message
      flash.now[:danger]="Please Enter Correct Password & Email Address"
      render "new"
    end
  end

  def destroy
    #render plain:"Some page Views"
     log_out
     flash[:success]="You are Successfully Signout"
     redirect_to login_url
  end
end
