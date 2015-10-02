class ProjectsController < AuthenticatesController

  def index
    @projects = current_user.user_projects
  end

  def new
    @project = Project.new

    respond_to do |format|
      format.html
      format.js {
        # TODO: Normally don't need this. Is there a better way?
        render layout: false
      }
    end
  end

  def create
    @project = current_user.projects.build(request_params)
    @project.admin = current_user

    if @project.save
      UserProject.create(user: current_user, project: @project)
      flash[:success] = "You successfully created a new project"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:project).permit(:project_name)
  end

end