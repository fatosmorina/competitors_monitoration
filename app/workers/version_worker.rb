class VersionWorker
  include Sidekiq::Worker

  def perform(asin)
    new_version = VersionService.new(asin).get_version
    last_version = Version.joins(:products).where(asin: asin).last
    last_version.assign_attributes(new_version) if last_version
    if last_version.blank? || last_version.changed?
      Version.create!(last_version)
    end
    sleep 4
  end
end
