json.array! @jobs do |job|
  json.extract! job, :id, :title, :total_pay, :spoken_languages
end
