#!/usr/bin/env ruby

require_relative './common.rb'

raise "usage: ruby #{$0} in_f.csv" unless f_file = ARGV.shift
CheckX.check_f_file(f_file)
