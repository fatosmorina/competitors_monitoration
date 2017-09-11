VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.default_cassette_options = {
    match_requests_on: [:method, :host, :path], record: :new_episodes
  }
  config.filter_sensitive_data("AWS_ACCESS_KEY_ID") { ENV['AWS_ACCESS_KEY_ID'] }
  config.filter_sensitive_data("AWS_SECRET_ACCESS_KEY") { ENV['AWS_SECRET_ACCESS_KEY'] } 
  config.filter_sensitive_data("AWS_ASSOCIATE_TAG") { ENV['AWS_ASSOCIATE_TAG'] } 
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = described_class.name.split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end
