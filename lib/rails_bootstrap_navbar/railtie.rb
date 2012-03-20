require 'rails_bootstrap_navbar/view_helpers'
module RailsBootstrapNavbar
  class Railtie < Rails::Railtie
    initializer "rails_bootstrap_navbar.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end