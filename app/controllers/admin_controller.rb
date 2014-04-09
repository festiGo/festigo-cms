class AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :supervise, :all
  end

  def users
    authorize! :supervise, :all
    @users = User.all
  end
end
