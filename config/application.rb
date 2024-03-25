require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ThrbAi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    #Passwordless mailer
    config.action_mailer.default_url_options = { host: 'localhost:3000' }
    # routes.default_url_options[:host] ||= "127.0.0.1:3000"
    # Where the I18n library should search for translation files
    #! Nasser : from https://guides.rubyonrails.org/i18n.html#configure-the-i18n-module
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    #! Nasser : i18n from Gemini
    config.i18n.available_locales = [:en, :ar]
    config.i18n.default_locale = :ar # Set your default language
    config.assets.css_compressor = nil
    # I18n.load_path += Dir[File.expand_path("config/locales") + "/*.yml"]
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
