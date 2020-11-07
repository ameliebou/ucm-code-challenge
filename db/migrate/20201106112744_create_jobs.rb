class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.float :salary_per_hour
      t.text :spoken_languages, array:true, default: []
      t.text :shifts, array:true, default: []

      t.timestamps
    end
  end
end
