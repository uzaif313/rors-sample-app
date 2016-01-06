class UsersController < ApplicationController
  before_action :logged_in_user,only:[:index,:edit,:update]
  before_action :correct_user,only:[:edit,:update]

  def index
    @users = User.paginate(:page=>params[:page],per_page:5)

  end

  def show
    @user=User.find(params[:id])
    # debugger
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      log_in @user
      flash[:success]="Welcome to the Sample Apps"
      redirect_to @user
    else
        render "new"
    end
  end

  def edit
    @user=User.find_by(:id=>params[:id]);
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]="Profile Updated successfully"
      redirect_to user_path
    else
      render "edit"
    end
  end



  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def logged_in_user
        unless logged_in?
          flash[:danger]="Access Denied  Please Login and View the Page"
          redirect_to login_url
        end
    end

    def correct_user
      user=User.find(params[:id])
      unless user==current_user
        redirect_to root_url
      end
    end
end
