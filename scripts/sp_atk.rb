#!/usr/bin/env ruby

require_relative './common.rb'

C = Common

def log(s, ferr = $stderr)
  ferr.puts "#{Time.now}: #{s}"
end

def main()
  log("begin #{$0}")
  raise "usage: ruby #{$0} input_dir_path in_my_id.txt out_scores.txt" unless ARGV.size >= 3
  input_path, my_id_file, score_file = ARGV

  my_id = nil
  File.open(my_id_file){|fin| my_id = fin.gets.chomp}
  raise "formatting error in my_id.txt" unless /\A\d\d\z/ =~ my_id

  scores = []
  scores << "atk_info_claimed_id:#{my_id}"
  scores << "atk_info_my_id_verified:#{1}"
  C::T.times do |i|
    id = sprintf("%02d", i+1)
    f_file = "#{input_path}/f_#{id}_#{my_id}.csv"
    log("try to find #{f_file}")
    score = 0
    if id == my_id
      log("skipped becaus id == my_id")
    elsif C::ANO_NO_SUBMISSION.include?(id)
      log("skipped due to non-submitted team")
    elsif !File.exist?(f_file)
      log("not found")
    else
      log("found")
      log("test f_#{id}_#{my_id}.csv")
      CheckX.check_f_file(f_file)
      score = 1
    end
    scores << "atk_submission_status_#{id}:#{score}"
  end
  
  log('write scores')
  File.open(score_file, 'w') do |fout|
    fout.puts scores
  end
  log("end #{$0}")
end

main()
