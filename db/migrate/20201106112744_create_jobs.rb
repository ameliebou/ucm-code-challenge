class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.float :salary_per_hour

      t.timestamps
    end
  end
end
