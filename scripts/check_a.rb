#!/usr/bin/env ruby

require_relative './common.rb'

raise "usage: ruby #{$0} in_a.csv" unless a_file = ARGV.shift
CheckX.check_a_file(a_file)
