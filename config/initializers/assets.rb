# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.application.config.assets.precompile += %w( custom-styles.css )
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( font-awesome.min.css )
Rails.application.config.assets.precompile += %w( owl.carousel.css)
Rails.application.config.assets.precompile += %w( footer.css)

Rails.application.config.assets.precompile += %w( bxslider.min.js)
Rails.application.config.assets.precompile += %w( custom-script.js)
Rails.application.config.assets.precompile += %w( custom.js)
Rails.application.config.assets.precompile += %w( jquery-1.10.2.js)
Rails.application.config.assets.precompile += %w( jquery.easing.1.3.min.js)
Rails.application.config.assets.precompile += %w( jquery.stick.js)
Rails.application.config.assets.precompile += %w( main.js)
Rails.application.config.assets.precompile += %w( owl.carousel.min.js)
Rails.application.config.assets.precompile += %w( script.slider.js)
Rails.application.config.assets.precompile += %w( countdown.js )
Rails.application.config.assets.precompile += %w( jquery.countdown.min.js )
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
