require "rails_bootstrap_navbar/version"

module RailsBootstrapNavbar
	module ViewHelpers

	  def nav_bar
			content_tag :div, :class => "navbar" do
				navbar_inner_div do
					container_div
				end
			end
	  end

	  private

	  def navbar_inner_div(&block)
			content_tag :div, :class => "navbar-inner" do
				yield
			end
	  end

	  def container_div(&block)
			content_tag :div, :class => "container" do
				yield if block_given?
			end
	  end
	end
end
