$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'kitno'

require 'minitest/autorun'
require "minitest/reporters"
require 'pry'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
