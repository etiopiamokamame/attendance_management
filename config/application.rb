require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AttendanceManagementV2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.enable_dependency_loading = true
    config.autoload_paths           += %W(#{config.root}/lib)
    config.i18n.load_path           += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    config.i18n.default_locale       = :ja

    config.action_view.field_error_proc = proc do |html_tag, instance|
      method_name    = instance.instance_eval("@method_name")
      errors         = instance.object.errors[method_name.to_sym]
      error_messages = errors.map do |error|
        <<~EOS
          <span class="help-block">
            #{error}
          </span>
        EOS
      end

      <<~EOS.html_safe
        <span class="has-error">
          #{html_tag}
          #{error_messages.join}
        </span>
      EOS
    end
  end
end
