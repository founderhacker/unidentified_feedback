class AddDelayedJobScheduledAtToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :delayed_job_scheduled_at, :integer
  end
end
