include ActionView::Helpers::TextHelper

class ProjectsController < AuthenticatesController

  def new
    @project = Project.new

    respond_to do |format|
      format.js
    end
  end

  def create
    @project = current_user.projects.build(request_params)
    @project.admin = current_user

    if @project.save
      UserProject.create(user: current_user, project: @project)
      flash[:notice] = "You successfully created a new project"
      redirect_to root_path
    else
      redirect_to :back, alert: parse_errors(@project.errors)
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  def request_params
    params.require(:project).permit(:project_name)
  end

  def parse_errors(errors)
    error_msg_array = errors[errors.keys.first.to_s]
    "#{pluralize(error_msg_array.length, 'error')}: #{error_list(error_msg_array)}"
  end

  def error_list(error_array)
    errors = []
    error_array.each do |error|
      errors << "Project name #{error}"
    end
    errors.to_sentence
  end

end