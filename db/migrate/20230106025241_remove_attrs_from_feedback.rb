class RemoveAttrsFromFeedback < ActiveRecord::Migration[7.0]
  def change
    remove_column :feedbacks, :delayed_job_scheduled_at, :string
    remove_column :feedbacks, :delayed_job_id, :string
  end
end
