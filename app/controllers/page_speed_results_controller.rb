require_dependency "google_page_speed_api/client"

class PageSpeedResultsController < AuthenticatesController

  def new
    @project = Project.find(params[:id])
    @page_speed_form = PageSpeedForm.new
  end

  def create
    clean_up_strategy_params_array # remove empty string at start
    @project = Project.find(params[:id])
    @page_speed_form = PageSpeedForm.new(page_speed_form_params)

    is_form_valid?
  rescue GooglePageSpeedAPI::RequestFailure => e
    flash[:alert] = e.message
    render :new
  end

  private

  def clean_up_strategy_params_array
    params[:page_speed_form][:strategy].shift
  end

  def page_speed_form_params
    params.require(:page_speed_form).permit(:site_address, strategy: [])
  end

  def is_form_valid?
    if @page_speed_form.valid?
      site_analysis_array = page_speed_api_client.create_page_speed_insight(web_address, strategies_selected)
      store_results(site_analysis_array)

      flash[:notice] = "Analysis is complete"

      redirect_to root_path
    else
      render :new
    end
  end

  def page_speed_api_client
    GooglePageSpeedAPI::Client.new
  end

  def web_address
    params[:page_speed_form][:site_address]
  end

  def strategies_selected
    params[:page_speed_form][:strategy]
  end

  def store_results(site_analysis_array)
    project_id = @project.id
    PageSpeedResult.store_overview_data(site_analysis_array, project_id)
  end

end