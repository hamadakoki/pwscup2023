#!/usr/bin/env ruby

require_relative './common.rb'

def exec(cmd)
  $stdout.puts cmd
  `#{cmd}`
end

raise "usage: ruby #{$0} in_my_id.txt in_f.csv out_dir" unless ARGV.size >= 3
my_id_file, f0_file, output_path = ARGV

my_id = nil
File.open(my_id_file){|fin| my_id = fin.gets.chomp}
raise unless /\A\d\d\z/ =~ my_id

Common::T.times do |i|
  id = sprintf("%02d", i+1)
  next if id == my_id
  f_file = "#{output_path}/f_#{id}_#{my_id}.csv"
  exec("cp #{f0_file} #{f_file}")
end
