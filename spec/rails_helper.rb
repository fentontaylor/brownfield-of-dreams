require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |config|
  # config.allow_http_connections_when_no_cassette = true
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<YOUTUBE_API_KEY>') { ENV['YOUTUBE_API_KEY'] }
end

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start 'rails'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

def stub_default_github_info
  stub_github_info('fentons')
end

# pass user as "fentons", "nancys", or "nathans" to use stubbed_github_info
def stub_github_info(user)
  repos = File.open("./fixtures/#{user}_repos.json")
  stub_request(:get, 'https://api.github.com/user/repos?affiliation=owner')
    .to_return(status: 200, body: repos)
  followers = File.open("./fixtures/#{user}_followers.json")
  stub_request(:get, 'https://api.github.com/user/followers?affiliation=owner')
    .to_return(status: 200, body: followers)
  following = File.open("./fixtures/#{user}_following.json")
  stub_request(:get, 'https://api.github.com/user/following?affiliation=owner')
    .to_return(status: 200, body: following)
end
