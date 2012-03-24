# RailsBootstrapNavbar [![Build Status](https://secure.travis-ci.org/julescopeland/Rails-Bootstrap-Navbar.png?branch=master)](http://travis-ci.org/julescopeland/Rails-Bootstrap-Navbar)

The idea behind this gem is to make a really easy to use DSL for writing navbars for your rails apps, assuming you're already using Twitter Bootstrap >= 2.0 and Erb (It shouldn't make any difference how you ultimately get bootstrap into your app - i.e. through the sass-bootstrap gem, manually downloading the complied source, magic, whatever...). Just remember to include the javascript if you want things like dropdowns or responsive layouts.

## Installation

Add this line to your application's Gemfile:

    gem 'rails_bootstrap_navbar'


You need some form of Twitter bootstrap integration as well (I use Thomas McDonald's excellent [bootstrap-sass](https://github.com/thomas-mcdonald))

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_bootstrap_navbar

## Usage

This gem aims to automate all of the features currently mentioned on the [twitter bootstrap docs re. the navbar](http://twitter.github.com/bootstrap/components.html#navbar).

It should let you write things like:

````
<%= nav_bar :fixed => :top, :brand => "Fashionable Clicheizr 2.0", :responsive => true do %>
	<%= menu_group do %>
		<%= menu_item "Home", root_path %>
		<%= menu_divider %>
		<%= drop_down "Products" do %>
			<%= menu_item "Things you can't afford", expensive_products_path %>
			<%= menu_item "Things that won't suit you anyway", harem_pants_path %>
			<%= menu_item "Things you're not even cool enough to buy anyway", hipster_products_path %>
			<% if current_user.lives_in_hackney? %>
				<%= menu_item "Bikes", fixed_wheel_bikes_path %>
			<% end %>
		<% end %>
		<%= menu_item "About Us", about_us_path %>
		<%= menu_item "Contact", contact_path %>
	<% end %>
	<%= menu_group :pull => :right do %>
		<% if current_user %>
			<%= menu_item "Log Out", log_out_path %>
		<% else %>
			<%= form_for @user, :url => session_path(:user), html => {:class=> "navbar-form pull-right"} do |f| -%>
			  <p><%= f.text_field :email %></p>
			  <p><%= f.password_field :password %></p>
			  <p><%= f.submit "Sign in" %></p>
			<% end -%>
		<% end %>
	<% end %>
<% end %>
````

### Navbar scaffolding

In your view file (most likely application.html.erb) to get a basic navbar set up you need to do this:

````
<%= nav_bar  %>
````

Which will render:

	<div class="navbar">
	  <div class="navbar-inner">
	    <div class="container">
	    </div>
	  </div>
	</div>


### Fixed navbar

If you want the navbar to stick to the top of the screen, pass in the option like this:

````
<%= nav_bar :fixed => :top  %>
````

To render:

	<div class="navbar navbar-fixed-top">
	  <div class="navbar-inner">
	    <div class="container">
	    </div>
	  </div>
	</div>


### Brand name

Add the name of your site on the left hand edge of the navbar. By default, it will link to root_url. Passing a brand_link option will set the url to whatever you want.

````
<%= nav_bar :brand => "We're sooo web 2.0alizr", :brand_link => account_dashboard_path  %>
````

Which will render:

	<div class="navbar">
	  <div class="navbar-inner">
	    <div class="container">
			<a class="brand" href="/accounts/dashboard">
			  We're sooo web 2.0alizr
			</a>
	    </div>
	  </div>
	</div>


### Optional responsive variation

If you want the responsive version of the navbar to work (One that shrinks down on mobile devices etc.), you need to pass this option:

````
<%= nav_bar :responsive => true %>
````
Which renders the html quite differently:


	<div class="navbar">
	  <div class="navbar-inner">
	    <div class="container">
	      <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
	      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </a>
	      <!-- Everything in here gets hidden at 940px or less -->
	      <div class="nav-collapse">
	        <!-- menu items gets rendered here instead -->
	      </div>
	    </div>
	  </div>
	</div>


### Nav links

This is the 'meat' of the code where you define your menu items.

You can group menu items in theoretical boxes which you can apply logic to - e.g. show different collections for logged in users/logged out users, or simply right align a group.

The active menu item will be inferred from the link for now.

The important methods here are menu_group and menu_item.

menu_group only takes one argument - :pull - this moves the group left or right when passed :left or :right.

menu_item generates a link wrapped in an li tag. It takes two arguments and an options hash. The first argument is the name (the text that will appear in the menu), and the path (which defaults to "#" if left blank). The rest of the options are passed straight through to the link_to helper, so that you can add classes, ids, methods or data tags etc.

````
<%= nav_bar :fixed => :top, :brand => "Ninety Ten" do %>
	<% menu_group do %>
		<%= menu_item "Home", root_path %>
		<%= menu_item "About Us", about_us_path %>
		<%= menu_item "Contact", contact_path %>
	<% end %>
	<% if current_user %>
		<%= menu_item "Log Out", log_out_path %>
	<% else %>
		<% menu_group :pull => :right do %>
			<%= menu_item "Sign Up", registration_path %>
			<% form_for @user, :url => session_path(:user) do |f| -%>
			  <p><%= f.text_field :email %></p>
			  <p><%= f.password_field :password %></p>
			  <p><%= f.submit "Sign in" %></p>
			<% end -%>
		<% end %>
	<% end %>
<% end %>
````

### Dropdown menus

For multi-level list options, where it makes logical sense to group menu items, or simply to save space if you have a lot of pages, you can group menu items into drop down lists like this:

````
<%= nav_bar do %>
	<%= menu_item "Home", root_path %>

	<%= drop_down "Products" do %>
		<%= menu_item "Latest", latest_products_path %>
		<%= menu_item "Top Sellers", popular_products_path %>
		<%= menu_item "Discount Items", discounted_products_path %>
	<% end %>

	<%= menu_item "About Us", about_us_path %>
	<%= menu_item "Contact", contact_path %>
<% end %>
````

### Dividers

Dividers are just vertical bars that visually separate logically disparate groups of menu items

````
<%= nav_bar :fixed => :bottom do %>
	<%= menu_item "Home", root_path %>
	<%= menu_item "About Us", about_us_path %>
	<%= menu_item "Contact", contact_path %>

	<%= menu_divider %>

	<%= menu_item "Edit Profile", edit_user_path(current_user) %>
	<%= menu_item "Account Settings", edit_user_account_path(current_user, @account) %>
	<%= menu_item "Log Out", log_out_path %>
<% end %>
````

### Forms in navbar

At the moment - this is just a how to...

You need to add this class to the form itself (Different form builders do this in different ways - please check out the relevant docs)

````css
.navbar-form
````
To pull the form left or right, add either of these classes:
````css
.pull-left
.pull-right
````

If you want the Bootstrap search box (I think it just rounds the corners), use:
````css
.navbar-search
````
Instead of:
````css
.navbar-form
````

To change the size of the form fields, use .span2 (or however many span widths you want) to the input itself.

### Component alignment

You can shift things to the left or the right across the nav bar. It's easiest to do this on grouped menu items:

````
<%= nav_bar :fixed => :bottom do %>
	<% menu_group do %>
		<%= menu_item "Home", root_path %>
		<%= menu_item "About Us", about_us_path %>
		<%= menu_item "Contact", contact_path %>
	<% end %>
	<% menu_group :pull => :right do %>
		<%= menu_item "Edit Profile", edit_user_path(current_user) %>
		<%= menu_item "Account Settings", edit_user_account_path(current_user, @account) %>
		<%= menu_item "Log Out", log_out_path %>
	<% end %>
<% end %>
````

### Text in the navbar

If you want to put regular plain text in the navbar anywhere, you do it like this:

````
<%= nav_bar :brand => "Apple" do %>
	<%= menu_text "We make shiny things" %>
	<%= menu_item "Home", root_path %>
	<%= menu_item "About Us", about_us_path %>
<% end %>
````
It also takes the :pull option to drag it to the left or right.

## Contributing

This is my first ever published gem - so please feel free to pull it apart and fix bits that are dumb. One of my biggest problems was getting Rspec to test it properly (only just bitten the bullet and gone full TDD). Cleaning up the specs would be a good place to start.

I'm guessing also that there's a much nicer way of doing the whole thing using Rails' form_builder approach, but this was where TDD got me...

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
