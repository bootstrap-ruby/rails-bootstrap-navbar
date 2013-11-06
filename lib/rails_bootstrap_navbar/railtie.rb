require 'bootstrap-navbar'

module BootstrapNavbar::Helpers
  def prepare_html(html)
    html.html_safe
  end
end

module RailsBootstrapNavbar
  class Railtie < Rails::Railtie
    config.after_initialize do
      BootstrapNavbar.configure do |config|
        config.current_url_method = if Rails.version >= '3.2'
          'request.original_url'
        else
          '[request.protocol, request.host_with_port, request.fullpath].join'
        end

        if Gem.loaded_specs.keys.include?('bootstrap-sass')
          bootstrap_sass_version = Gem.loaded_specs['bootstrap-sass'].version
          bootstrap_version = bootstrap_sass_version.to_s[0..4]
          config.bootstrap_version = bootstrap_version
        end
      end

      ActionView::Base.send :include, BootstrapNavbar::Helpers
    end
  end
end
