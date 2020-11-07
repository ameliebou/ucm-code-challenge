json.array! @jobs do |job|
  json.extract! job, :title, :total_pay, :spoken_languages
end
