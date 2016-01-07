class PasswordResetsController < ApplicationController
  before_action :get_user, only:   [:edit,:update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  # before_action :valid_user, only: [:edit,:update]

  def new
  end



 def create
    #  render json:params[:password_reset][:email]
    @user=User.find_by(email: params[:password_reset][:email])

    if @user

        @user.create_reset_digest
        @user.send_password_reset_email
        flash[:info]="Password Reset Link is Sent in Your mail"
      else
        flash[:danger]="Email is not Exist"
    end
    redirect_to root_url
  end

  def edit

  end

  def update
    # render plain:"Test template"
    #render json:@user
     if params[:user][:password].empty?
       @user.errors.add(:password,"Password Can't be Empty")
       render 'edit'
     elsif @user.update_attributes(user_params)
        log_in @user
        flash[:success] = "Password has been reset."
        redirect_to @user
      else
        render "edit"
     end
  end

  def get_user
    # render json:params
     @user = User.find_by(email: params[:email])
  end
  private

    def check_expiration
      if @user.password_reset_expired?
       flash[:danger] = "Password reset has expired."
       redirect_to new_password_reset_url
     end
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end


    def valid_user
      #  render json:params

      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

end
