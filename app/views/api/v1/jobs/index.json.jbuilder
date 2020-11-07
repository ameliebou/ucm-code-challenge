json.array! @jobs do |job|
  json.extract! job, :title, :salary_per_hour, :spoken_languages, :shifts
end
