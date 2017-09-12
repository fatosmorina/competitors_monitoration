every :day, :at => '12:00 am' do
   rake "versions:retrieve"
end

every :day, :at => '10:00 am' do
   rake "notifications:create"
end

