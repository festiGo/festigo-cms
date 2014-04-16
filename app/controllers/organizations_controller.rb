class OrganizationsController < InheritedResources::Base

  def show
    @organization = Organization.find_by_id(params[:id])
    @users = @organization.users
  end

end
