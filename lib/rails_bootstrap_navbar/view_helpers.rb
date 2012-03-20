require "rails_bootstrap_navbar/version"

module RailsBootstrapNavbar
	module ViewHelpers

	  def nav_bar(*args)
			nav_bar_div(args) do
				navbar_inner_div(args) do
					container_div(args)
				end
			end
	  end

	  private

	  def nav_bar_div(*args, &block)
			content_tag :div, :class => nav_bar_css_class(args) do
				yield
			end
	  end

	  def navbar_inner_div(*args, &block)
			content_tag :div, :class => "navbar-inner" do
				yield
			end
	  end

	  def container_div(*args, &block)
			options = args.flatten.extract_options!

			if options[:brand].present?
				brand_link = link_to(options[:brand], "/", :class => "brand")
			end

			content_tag :div, :class => "container" do
				if block_given?
					brand_link + yield
				else
					brand_link
				end
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
