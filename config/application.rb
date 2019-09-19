require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "net/http"

require "action_view/railtie"
require "sprockets/railtie"
require 'browserify-rails'
# require "rails/test_unit/railtie"
require 'sprockets/es6'
require 'vkontakte_api'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SpaApp
  class Application < Rails::Application

    config.angular_templates.ignore_prefix  = %w(app/templates/)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    config.browserify_rails.commandline_options = "-t [ babelify --presets [ es2015 ] ]"

    config.browserify_rails.commandline_options = "-t coffeeify --extension=\".js.coffee\""
    # config.browserify_rails.evaluate_node_modules = true

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.active_job.queue_adapter = :delayed_job

    config.assets.precompile.shift

    config.assets.precompile += %w( messages.css messages.js wiki.js )
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)


    # Add additional asset pathes
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components', 'bootstrap-sass-official', 'assets', 'fonts')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    # Precompile additional asset types
    config.assets.precompile += %w( auth.css auth.js )

    config.assets.precompile.push(Proc.new do |path|
         File.extname(path).in? [
           '.html', '.erb', '.haml',                 # Templates
           '.png',  '.gif', '.jpg', '.jpeg', '.svg', # Images
           '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
         ]
                                     end)
    config.middleware.insert_before 0, 'Rack::Cors' do
      allow do
        origins '*'
        resource '*',
                 :headers => :any,
                 :methods => [:get, :post, :delete, :put, :head]
      end
    end

    config.middleware.delete Rack::Lock
    config.middleware.use FayeRails::Middleware, mount: '/faye', :timeout => 25

    VkontakteApi.configure do |config|
      config.api_version = '5.59'
    end
  end
end
