# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
assets_files = %w(
                login.css
                users.css
                top.css
                system_configs.css
                user_configs.css
                reasons.css
                leave_types.css
                attendances.css
                login.js
                users.js
                reasons.js
                leave_types.js
                attendances.js
               )

Rails.application.config.assets.precompile += assets_files
