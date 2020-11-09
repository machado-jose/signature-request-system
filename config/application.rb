require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SignatureRequestSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Paperclip config
    Paperclip.options[:command_path] = "/usr/bin/"
    config.paperclip_defaults = { 
      storage: :fog, 
      fog_credentials: 
        { provider: "Local", 
          local_root: "#{Rails.root}/storage"
        }, 
      fog_directory: "", 
      fog_host: "http://localhost:3000"
    }
  end
end
