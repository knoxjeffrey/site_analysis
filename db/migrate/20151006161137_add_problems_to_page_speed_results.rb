class AddProblemsToPageSpeedResults < ActiveRecord::Migration
  def change
    add_column :page_speed_results, :problems, :jsonb
  end
end
