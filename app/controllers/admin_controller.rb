class AdminController < ApplicationController
  before_filter :authenticate_user!

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
