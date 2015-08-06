require 'minitest/autorun'
require 'minitest/pride'
require 'rake/testtask'
require 'pry'

gem 'simplecov', :require => false, :group => :test
require 'simplecov'
SimpleCov.start
