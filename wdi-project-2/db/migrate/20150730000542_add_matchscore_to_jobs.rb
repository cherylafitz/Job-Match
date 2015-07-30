class AddMatchscoreToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :matchscore, :integer
  end
end
