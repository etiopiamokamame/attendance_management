def load_config(key, filepath)
  yml = YAML.load_file filepath rescue nil
  abort "No such file #{filepath}" unless yml

  config = yml[Rails.env]
  abort "No such environment #{Rails.env} on #{filepath}" unless config

  Rails.application.config.send(
    "#{key}=".to_sym,
    ActiveSupport::InheritableOptions.new(config.deep_symbolize_keys)
    )
end

load_config :side_menu, Rails.root.join("config", "side_menu.yml")
