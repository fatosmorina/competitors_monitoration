namespace :notifications do
  desc "Get the latest versions of products" 
  task create: :environment do
    notification_created = false
    new_versions = Version.where("created_at >= ?", Time.zone.now.beginning_of_day)
    new_versions.each do |version|
      Notification.create(user: version.product.group.user, product_changed: version.product.asin)
      notification_created = true
    end
  end
end

