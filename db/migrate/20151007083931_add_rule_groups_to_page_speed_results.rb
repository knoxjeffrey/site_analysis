class AddRuleGroupsToPageSpeedResults < ActiveRecord::Migration
  def change
    add_column :page_speed_results, :rule_groups, :jsonb
  end
end
