class SessionsController < ApplicationController

  def new

  end

  def create

    #render json:params[:sessions][:email]+" "+params[:sessions][:password
    #render json:
    #render "new"
    #render  json:user.to_yaml

    @user = User.find_by(email:params[:sessions][:email].downcase)
    if @user && @user.authenticate(params[:sessions][:password])
      # Do the Login Successfully

       if @user.activated?
        #  render json:
         log_in @user
         params[:sessions][:remember_me] == '1' ? remember(@user) : forget(@user)
         redirect_to @user
       else
         flash[:warning]="Account is Not Activated Yet Please Check Your Email and Activate Account"
         redirect_to root_url
       end
    else
      #Login Faild Redirect User to Login page with Flash Message
      flash.now[:danger]="Please Enter Correct Password & Email Address"
      render "new"
    end
  end

  def destroy
    #render plain:"Some page Views"
     log_out if logged_in?
     flash[:success]="You are Successfully Signout"
     redirect_to login_url
  end
end
