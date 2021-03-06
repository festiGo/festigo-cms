class AdminController < ApplicationController
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |f|
      flash[:error] = t('common.not_allowed')
      f.any(:html) { redirect_to root_path }
    end
  end


  def index
    authorize! :supervise, :all
  end

  def users
    authorize! :supervise, :all
    @users = User.all
  end

  def show_user
    authorize! :supervise, :all
    @user = User.find_by_id(:user_id)
  end
end
