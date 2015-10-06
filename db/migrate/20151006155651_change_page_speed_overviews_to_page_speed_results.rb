class ChangePageSpeedOverviewsToPageSpeedResults < ActiveRecord::Migration
  def change
    rename_table :page_speed_overviews, :page_speed_results
  end
end
