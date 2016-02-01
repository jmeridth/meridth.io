path = File.expand_path("../", __FILE__)

require 'rubygems'
require 'bundler'
require 'sinatra'
require "#{path}/app"

run Sinatra::Application
