class UserProjectsController < AuthenticatesController

  def index
    @user_projects = current_user.user_projects
  end

end