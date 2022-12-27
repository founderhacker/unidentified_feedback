class AddDelayedJobIdToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :delayed_job_id, :integer
  end
end
