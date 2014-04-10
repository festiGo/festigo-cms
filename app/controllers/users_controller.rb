class UsersController < ApplicationController
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |f|
      flash[:error] = t('common.not_allowed')
      f.any(:html) { redirect_to root_path }
    end
  end


  def index
    authorize! :supervise, :all
    @users = User.all
  end

  def show
    authorize! :supervise, :all
    @user = User.find(params[:id])
  end

  def new
    authorize! :supervise, :all

  end

  def profile
    @user = User.find(current_user.id)
  end
end
