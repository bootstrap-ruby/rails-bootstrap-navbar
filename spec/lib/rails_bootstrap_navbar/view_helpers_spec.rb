# encoding: utf-8
require 'spec_helper'
require 'action_view'
require 'active_support'

include RailsBootstrapNavbar::ViewHelpers
include ActionView::Helpers
include ActionView::Context

describe RailsBootstrapNavbar::ViewHelpers, :type => :helper do
	before { self.stub!("current_page?").and_return(false) }
  describe "nav_bar" do
    it "should return a basic bootstrap navbar" do
			nav_bar.gsub(/\s/,'').downcase.should eql(BASIC_NAVBAR.gsub(/\s/,'').downcase)
    end

    it "should set the fixed position to top" do
      nav_bar(:fixed => :top).gsub(/\s/,'').downcase.should eql(FIXED_TOP_NAVBAR.gsub(/\s/,'').downcase)
    end

    it "should set the fixed position to bottom" do
      nav_bar(:fixed => :bottom).gsub(/\s/,'').downcase.should eql(FIXED_BOTTOM_NAVBAR.gsub(/\s/,'').downcase)
    end

    it "should add the brand name and link it to the home page" do
      nav_bar(:brand => "Ninety Ten").gsub(/\s/,'').downcase.should eql(NAVBAR_WITH_BRAND.gsub(/\s/,'').downcase)
    end

    it "should set the container to fluid" do
      nav_bar(:fluid => :true).gsub(/\s/,'').downcase.should eql(BASIC_NAVBAR_FLUID.gsub(/\s/,'').downcase)
    end

    it "should add the buttons etc for a responsive layout with no block passed" do
      nav_bar(:responsive => true).gsub(/\s/,'').downcase.should eql(RESPONSIVE_NAVBAR.gsub(/\s/,'').downcase)
    end

    it "should add the buttons etc for a responsive layout with block passed" do
      nav_bar(:responsive => true) do
				"<p>Passing a block</p>"
			end.gsub(/\s/,'').downcase.should eql(RESPONSIVE_NAVBAR_WITH_BLOCK.gsub(/\s/,'').downcase)
    end

    it "should render contained items" do
      nav_bar do
				menu_group do
					menu_item "Home", "/"
				end
      end.gsub(/\s/,'').downcase.should eql(PLAIN_NAVBAR_WITH_ITEM.gsub(/\s/,'').downcase)
    end

    it "should still render the brand name even with other options turned on" do
			nav_bar(:brand => "Something") do
				menu_group do
					menu_item "Home", "/"
				end
      end.gsub(/\s/,'').downcase.should eql(BRANDED_NAVBAR_WITH_ITEM.gsub(/\s/,'').downcase)
    end
  end

  describe "menu_group" do
    it "should return a ul with the class 'nav'" do
      menu_group do
				"<p>This is a menu group</p>"
      end.should eql('<ul class="nav"><p>This is a menu group</p></ul>')
    end

    it "should return a ul with class .pull-left when passed the {:pull => :left} option" do
			menu_group(:pull => :left) do
				"<p>This is a menu group</p>"
      end.should eql('<ul class="nav pull-left"><p>This is a menu group</p></ul>')
    end
  end

  describe "menu_item" do
    it "should return a link within an li tag" do
			self.stub!("current_page?").and_return(false)
      menu_item("Home", "/").should eql('<li><a href="/">Home</a></li>')
    end
    it "should return the link with class 'active' if on current page" do
      self.stub!("current_page?").and_return(true)
      menu_item("Home", "/").should eql('<li class="active"><a href="/">Home</a></li>')
    end
  end

  describe "drop_down" do
    it "should do render the proper drop down code" do
      drop_down "Products" do
				menu_item "Latest", "/"
      end.gsub(/\s/,'').downcase.should eql(DROPDOWN_MENU.gsub(/\s/,'').downcase)
    end
  end

  describe "menu_divider" do
		it "should render <li class='divider-vertical'></li>" do
		  menu_divider.should eql '<li class="divider-vertical"></li>'
		end
  end

  describe "menu_text" do
    it "should render text within p tags" do
      menu_text("Strapline!").should eql("<p>Strapline!</p>")
    end

    it "should be able to cope with a block too" do
      menu_text do
				"I've been rendered programmatically!"
      end.should eql("<p>I've been rendered programmatically!</p>")
    end
  end

  describe "rendering forms ok" do
		it "should not escape anything unexpectedly" do
	    nav_bar do
				form_tag "/", :method => 'get' do |f|
					f.text_field :search, "stub"
				end
	    end.gsub(/\s/,'').downcase.should eql(PLAIN_NAVBAR_WITH_FORM.gsub(/\s/,'').downcase)
	  end
  end

  describe "Integration with everything" do
		let(:current_user) { mock("User") }
		before { current_user.stub(:lives_in_hackney?).and_return(true) }
    it "should be able to do the readme example" do
      nav_bar :fixed => :top, :brand => "Fashionable Clicheizr 2.0", :responsive => true, :fluid => true do
				menu_group do
					menu_item "Home", "/"
					menu_divider
					drop_down "Products" do
						menu_item "Things you can't afford", "/products/expensive"
						menu_item "Things that won't suit you anyway", "/harem/pants"
						menu_item "Things you're not even cool enough to buy anyway", "/products/hipsters"
						if current_user && current_user.lives_in_hackney?
							menu_item "Bikes", "/bikes/fixed-wheel"
						end
					end
					menu_item "About Us", "/about"
					menu_item "Contact", "/contact"
				end
				menu_group :pull => :right do
					if current_user
						menu_item "Log Out", "/users/signout"
					else
						form_for @user, :url => session_path(:user), html => {:class=> "navbar-form pull-right"} do |f|
						  f.text_field :email
						  f.password_field :password
						  f.submit "Sign in"
						end
					end
				end
			end.gsub(/\s/,'').downcase.should eql(README_EXAMPLE.gsub(/\s/,'').downcase)
    end
  end

end

# HTML output

BASIC_NAVBAR = <<-HTML
<div class="navbar">
  <div class="navbar-inner">
    <div class="container">
    </div>
  </div>
</div>
HTML

FIXED_TOP_NAVBAR = <<-HTML
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
    </div>
  </div>
</div>
HTML

FIXED_BOTTOM_NAVBAR = <<-HTML
<div class="navbar navbar-fixed-bottom">
  <div class="navbar-inner">
    <div class="container">
    </div>
  </div>
</div>
HTML

BASIC_NAVBAR_FLUID= <<-HTML
<div class="navbar">
  <div class="navbar-inner">
    <div class="container-fluid">
    </div>
  </div>
</div>
HTML

NAVBAR_WITH_BRAND = <<-HTML
<div class="navbar">
  <div class="navbar-inner">
    <div class="container">
			<a href="/" class="brand">
			  Ninety Ten
			</a>
    </div>
  </div>
</div>
HTML

RESPONSIVE_NAVBAR = <<-HTML
<div class="navbar">
  <div class="navbar-inner">
    <div class="container">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <div class="nav-collapse">
      </div>
    </div>
  </div>
</div>
HTML

RESPONSIVE_NAVBAR_WITH_BLOCK = <<-HTML
<div class="navbar">
  <div class="navbar-inner">
    <div class="container">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <div class="nav-collapse">
				<p>Passing a block</p>
      </div>
    </div>
  </div>
</div>
HTML

PLAIN_NAVBAR_WITH_ITEM = <<-HTML
<div class="navbar">
	<div class="navbar-inner">
		<div class="container">
			<ul class="nav">
				<li>
					<a href="/">Home</a>
				</li>
			</ul>
		</div>
	</div>
</div>
HTML

BRANDED_NAVBAR_WITH_ITEM = <<-HTML
<div class="navbar">
	<div class="navbar-inner">
		<div class="container">
			<a href="/" class="brand">
			  Something
			</a>
			<ul class="nav">
				<li>
					<a href="/">Home</a>
				</li>
			</ul>
		</div>
	</div>
</div>
HTML

DROPDOWN_MENU = <<-HTML
<li class="dropdown">
  <a href="#"
        class="dropdown-toggle"
        data-toggle="dropdown">
        Products
        <b class="caret"></b>
  </a>
  <ul class="dropdown-menu">
    <li><a href="/">Latest</a></li>
  </ul>
</li>
HTML

PLAIN_NAVBAR_WITH_FORM = <<-HTML
<div class="navbar">
	<div class="navbar-inner">
		<div class="container">
			<form accept-charset="utf-8" action="/" method="get">
				<div style="margin:0;padding:0;display:inline">
					<input name="utf8" type="hidden" value="&#x2713;"/>
				</div>
				<input id="search_stub" name="search[stub]" size="30" type="text"/>
			</form>
		</div>
	</div>
</div>
HTML

README_EXAMPLE = <<-HTML
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container-fluid">
			<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</a>
			<a href="/"class="brand">
				fashionableclicheizr2.0
			</a>
			<div class="nav-collapse">
				<ul class="nav">
					<li><a href="/">Home</a></li>
					<li class="divider-vertical"></li>
					<li class="dropdown">
					  <a href="#"
					        class="dropdown-toggle"
					        data-toggle="dropdown">
					        Products
					        <b class="caret"></b>
					  </a>
					  <ul class="dropdown-menu">
					    <li><a href="/products/expensive">Things you can't afford</a></li>
					    <li><a href="/harem/pants">Things that won't suit you anyway</a></li>
					    <li><a href="/products/hipsters">Things you're not even cool enough to buy anyway</a></li>
					    <li><a href="/bikes/fixed-wheel">Bikes</a></li>
					  </ul>
					</li>
					<li><a href="/about">About Us</a></li>
					<li><a href="/contact">Contact</a></li>
				</ul>

				<ul class="nav pull-right">
					<li>
						<a href="/users/signout">
							logout
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
HTML