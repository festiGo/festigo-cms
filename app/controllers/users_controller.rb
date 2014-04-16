class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_user_admin, except: [:profile]

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |f|
      flash[:error] = t('common.not_allowed')
      f.any(:html) { redirect_to root_path }
    end
  end


  def create
    @user = User.new(params[:user])
    @user.password_confirmation = @user.password
    # @user.skip_confirmation!

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @devices = @user.devices
    @checkins = @user.my_checkins
  end

  def new
    @user = User.new
    @organizations = Organization.all
  end

  def edit
    @user = User.find(params[:id])
    @organizations = Organization.all
  end

  def profile
    @user = User.find(current_user.id)
  end

  private

  def check_user_admin
    authorize! :supervise, :all
  end
end
