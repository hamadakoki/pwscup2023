#!/usr/bin/env ruby

require_relative './common.rb'

C = Common

def log(s, ferr = $stderr)
  ferr.puts "#{Time.now}: #{s}"
end

def main()
  log("begin #{$0}")
  raise "usage: ruby #{$0} in_p.csv in_r.csv in_seed.txt in_a.csv out_u_scores.txt" unless ARGV.size >= 5
  p_file, r_file, seed_file, a_file, score_file = ARGV
  
  log('check R')
  CheckX.check_r_file(r_file)
  log('read R')
  r = C.read_csv_file(r_file)
  
  log('check A')
  CheckX.check_a_file(a_file)
  log('read A')
  a = C.read_csv_file(a_file)

  log('gen R2 from Seed')
  r2 = GenR.gen(seed_file)
  log('conv R2')
  r2 = r2.map{|r2_i| r2_i.map(&:to_s)}
  log('compare R and R2')
  raise unless r == r2

  log('read P')
  p = C.read_csv_file(p_file)
  
  log('make O')
  o = C.pr2o(p, r)

  log('comute utlity score')
  normalized_score, raw_score = Scores.utility(o, a)
  scores = [
    sprintf("ano_reserved_0:%.4f", normalized_score),
    "util_raw_score:#{raw_score}"
  ]
  
  log('write scores')
  File.open(score_file, 'w') do |f|
    f.puts scores
  end
  log("end #{$0}")
end

main()
