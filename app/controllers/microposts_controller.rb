class MicropostsController < ApplicationController
  before_action :logged_in_user ,only: [:create,:destroy]
  before_action :correct_user ,only: :destroy

  def create
    @micropost=current_user.microposts.build(micropost_params)
    if @micropost.save
        flash[:success]="Post Created Successfully"
        redirect_to root_url
    else
        flash[:danger]="Unable to Publish Your Post"
        render "static_pages/home"
    end
  end

  def destroy

    @micropost.destroy
    flash[:success]="Successfully Deleted Post"
    redirect_to request.referrer || root_url
  end

  private
    def correct_user
      @micropost=current_user.microposts.find_by(id:params[:id])
      # raise @micropost.inspect
      redirect_to root_url if @micropost.nil?
    end

    def micropost_params
      params.require(:micropost).permit(:content,:picture)
    end

end
