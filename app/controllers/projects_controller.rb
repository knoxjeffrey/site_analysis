class ProjectsController < AuthenticatesController

  def index
    @projects = current_user.projects
  end

  def new

  end

  def create

  end

end