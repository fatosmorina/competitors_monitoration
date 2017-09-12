namespace :versions do
  desc "Get the latest versions of products" 
  task retrieve: :environment do 
    asins = Product.pluck(:asin)
    asins.each do |asin|
      VersionWorker.perform_in(5.seconds, asin) 
    end
  end
end
