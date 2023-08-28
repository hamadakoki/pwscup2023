#!/usr/bin/env ruby

require_relative './common.rb'

C = Common

seed = ARGV.shift
srand(seed.to_i) if seed

n, m = [C::N, C::MP]
a = (0...n).map{ (0...m).map{ [rand(C::C), rand(C::C)].min } }
C.write_csv(a)
