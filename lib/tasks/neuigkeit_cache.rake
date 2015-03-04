namespace :neuigkeit_cache do
	  task :update =>:environment do
	       Neuigkeit.all.each do |n|
	       n.update_cache
	       end
	  end
end	  