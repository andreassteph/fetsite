every 1.day, :at =>'5:00 am' do
  rake "-s sitemap:refresh"
end
every 1.day, :at =>'4:00 am' do
  rake "-s neuigkeit_cache:update"
end
every 1.day, :at =>'3:00 am' do
  rake "-s crawler:run"
end
