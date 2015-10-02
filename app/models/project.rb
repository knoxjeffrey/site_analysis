class Project < ActiveRecord::Base

  has_many :user_groups
  has_many :users, through: :user_groups
  belongs_to :admin, foreign_key: 'admin_id', class_name: 'User'
end