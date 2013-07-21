require 'spec_helper'

require 'rails'
require 'rails_bootstrap_navbar/railtie'

describe RailsBootstrapNavbar::Railtie do
  it 'sets BootstrapNavbar.current_url_method' do
    BootstrapNavbar.current_url_method.should_not be_nil
  end
end
