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
    config.autoload_paths     += %W(#{config.root}/lib)
    config.i18n.load_path     += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    config.i18n.default_locale = :ja

    config.action_view.field_error_proc = proc do |html_tag, instance|
      method_name   = instance.instance_eval("@method_name")
      error_type    = instance.object.errors.details[method_name.try(:to_sym)].first
      error_message = unless error_type.blank?
                        <<~EOS
                          <span class="help-block">
                            #{I18n.t("form_errors")[error_type[:error]]}
                          </span>
                        EOS
                      end

      <<~EOS.html_safe
        <span class="has-error">
          #{html_tag}
          #{error_message}
        </span>
      EOS
    end
  end
end
