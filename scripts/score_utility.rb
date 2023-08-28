#!/usr/bin/env ruby

require_relative './common.rb'

raise "usage: ruby #{$0} in_p.csv in_r.csv in_a.csv" unless ARGV.size >= 3
p_file, r_file, a_file = ARGV

p = Common.read_csv_file(p_file)
r = Common.read_csv_file(r_file)
a = Common.read_csv_file(a_file)
o = Common.pr2o(p, r)
normalized_score, raw_score = Scores.utility(o, a)
$stdout.puts sprintf("%.4f", normalized_score)
