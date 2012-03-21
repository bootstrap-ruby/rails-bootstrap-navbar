require "rails_bootstrap_navbar/version"

module RailsBootstrapNavbar
	module ViewHelpers

	  def nav_bar(options={}, &block)
			nav_bar_div(options[:fixed]) do
				navbar_inner_div do
					container_div(options[:brand], options[:responsive], options[:fluid]) do
						yield if block_given?
					end
				end
			end
	  end

	  def menu_group(options={}, &block)
			pull_class = " pull-#{options[:pull].to_s}" if options[:pull].present?
			content_tag(:ul, :class => "nav#{pull_class}") {yield.html_safe}
	  end

	  def menu_item(name, path)
			content_tag :li, :class => is_active?(path) do
				link_to name, path
			end
	  end

	  def drop_down(name)
			content_tag :li, :class => "dropdown" do
				drop_down_link(name) + drop_down_list {yield}
			end
	  end

	  def menu_divider
			content_tag :li, "", :class => "divider-vertical"
	  end

	  def menu_text(text=nil, &block)
			content_tag :p do
				text || yield
			end
	  end

	  private

	  def nav_bar_div(fixed, &block)
			content_tag :div, :class => nav_bar_css_class(fixed) do
				yield
			end
	  end

	  def navbar_inner_div(&block)
			content_tag :div, :class => "navbar-inner" do
				yield
			end
	  end

	  def container_div(brand, responsive, fluid, &block)
			content_tag :div, :class => "container#{"-fluid" if fluid}" do
				container_div_with_block(brand, responsive) {yield}
			end
	  end

	  def container_div_with_block(brand, responsive, &block)
			output = []
			if responsive
				output << responsive_button
				output << responsive_div(brand) {yield}
			else
				output << brand_link(brand)
				output << yield
			end
			output.join("\n").html_safe
	  end

	  def nav_bar_css_class(fixed_pos)
			css_class = ["navbar"]
			css_class << "navbar-fixed-#{fixed_pos.to_s}" if fixed_pos.present?
			css_class.join(" ")
	  end

	  def brand_link(name)
			return "" if name.blank?
			link_to(name, "/", :class => "brand")
	  end

	  def responsive_button
			%{<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </a>}
	  end

	  def responsive_div(brand, &block)
			output = []
			output << brand_link(brand)
			output << yield
			content_tag(:div, :class => "nav-collapse") do
				output.join("\n").html_safe
			end
	  end

	  def is_active?(path)
			"active" if current_page?(path)
	  end

	  def name_and_caret(name)
			"#{name} #{content_tag(:b, :class => "caret"){}}".html_safe
	  end

	  def drop_down_link(name)
			link_to(name_and_caret(name), "#", :class => "dropdown-toggle", "data-toggle" => "dropdown")
	  end

	  def drop_down_list(&block)
			content_tag :ul, :class => "dropdown-menu" do
				yield
			end
	  end
	end
end