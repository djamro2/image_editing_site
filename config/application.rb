require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImageEditingSite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_dispatch.default_headers = {
	    'Access-Control-Allow-Origin' => '*',
	    'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",") # or whatever else you would like to allow
	}

  end
end
