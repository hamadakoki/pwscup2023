#!/usr/bin/env ruby

require_relative './common.rb'

raise "usage: ruby #{$0} in_r.csv in_f.csv" unless ARGV.size >= 2
r_file, f_file = ARGV

r = Common.read_csv_file(r_file)
f = Common.read_csv_file(f_file)
normalized_score, raw_score = Scores.attack(r, f)
$stdout.puts sprintf("%.4f", normalized_score)
