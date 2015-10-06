class PageSpeedOverview < ActiveRecord::Base
  belongs_to :project

  def self.store_overview_data(site_analysis_array, project_id)
    site_analysis_array.each do |data|
      PageSpeedOverview.create(project_id: project_id, address: data.site_address, strategy: data.strategy, speed: data.speed, usability: data.usability, stats: data.stats, insights: data.insights)
    end
  end

end