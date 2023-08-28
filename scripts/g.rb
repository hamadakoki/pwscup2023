#!/usr/bin/env ruby

require_relative './common.rb'

raise "usage: ruby #{$0} in_seed.txt out_r.csv" unless ARGV.size >= 2
seed_file, r_file = ARGV
r = GenR.gen(seed_file)
Common.write_csv_file(r, r_file)
