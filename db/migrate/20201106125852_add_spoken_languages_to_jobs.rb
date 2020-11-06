class AddSpokenLanguagesToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :spoken_languages, :text, array:true, default: []
  end
end
