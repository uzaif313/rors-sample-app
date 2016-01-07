class UsersController < ApplicationController
  before_action :logged_in_user,only:[:index,:edit,:update]
  before_action :correct_user,only:[:edit,:update]
  before_action :admin_user ,only: :destroy
  def index
    if current_user.admin?
      @users = User.paginate(:page=>params[:page],per_page:5)
    else
      @users = User.where(:activated=>true).paginate(:page=>params[:page],per_page:5)
    end
  end

  def show
   @user=User.find_by(id: params[:id])
   @microposts=@user.microposts.paginate(:page=>params[:page],per_page:10)
    # debugger
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      @user.send_activation_email
      # log_in @user
      flash[:info]="Please Check Your Email Address  to Activate Account"
      redirect_to root_url
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

  def destroy

    user=User.find_by(id:params[:id])
    name=user.name
    if !user.admin? && user.destroy
      flash[:success]="<strong>#{name}</strong> is Deleted Successfully"
      redirect_to users_url
      else
      flash[:danger]="Unable to Delete #{name}"
      redirect_to users_url
    end

  end



  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

  

    def correct_user
      user=User.find(params[:id])
      unless user==current_user
        redirect_to root_url
      end
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
