require "rails_bootstrap_navbar/version"

module RailsBootstrapNavbar
	module ViewHelpers

	  def nav_bar(*args)
			nav_bar_div(args) do
				navbar_inner_div do
					container_div
				end
			end
	  end

	  private

	  def nav_bar_div(*args, &block)
			content_tag :div, :class => nav_bar_css_class(args) do
				yield
			end
	  end

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

	  def nav_bar_css_class(*args)
			options = args.flatten.extract_options!
			fixed_pos = options[:fixed]
			css_class = ["navbar"]
			if fixed_pos.present?
				css_class << "navbar-fixed-#{fixed_pos.to_s}"
			end
			css_class.join(" ")
	  end
	end
end
