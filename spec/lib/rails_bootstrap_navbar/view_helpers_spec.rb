# encoding: utf-8
require 'spec_helper'
require 'action_view'
require 'active_support'

include RailsBootstrapNavbar::ViewHelpers
include ActionView::Helpers
include ActionView::Context

describe RailsBootstrapNavbar::ViewHelpers, :type => :helper do
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