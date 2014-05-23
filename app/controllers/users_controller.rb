class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_user_admin, except: [:profile]
  before_filter :load_organizations, only: [:show, :new, :edit]

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

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
  end

  def edit
    @user = User.find(params[:id])
  end

  def profile
    @user = User.find(current_user.id)
  end

  def assign_to_organization
    @user = User.find(params[:id])
    organization = Organization.find(params[:user][:organization_id])
    @user.organization = organization unless organization.nil?
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, notice: 'Assigned to organization.' ) }
      else
        format.html { redirect_to(@user, notice: 'Could not assign to organization.' )}
      end
    end
  end

  private

  def check_user_admin
    authorize! :supervise, :all
  end

  def load_organizations
    @organizations = Organization.all
  end
end
