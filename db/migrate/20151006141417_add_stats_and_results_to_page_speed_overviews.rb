class AddStatsAndResultsToPageSpeedOverviews < ActiveRecord::Migration
  def change
    add_column :page_speed_overviews, :stats, :jsonb
    add_column :page_speed_overviews, :insights, :jsonb
  end
end
