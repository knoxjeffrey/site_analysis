class CreatePageSpeedOverviews < ActiveRecord::Migration
  def change
    create_table :page_speed_overviews do |t|
      t.integer :project_id
      t.string :address
      t.string :strategy
      t.integer :speed
      t.integer :usability

      t.timestamps
    end
  end
end
