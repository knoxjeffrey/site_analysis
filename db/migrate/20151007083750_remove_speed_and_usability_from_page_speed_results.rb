class RemoveSpeedAndUsabilityFromPageSpeedResults < ActiveRecord::Migration
  def change
    remove_column :page_speed_results, :speed
    remove_column :page_speed_results, :usability
  end
end
