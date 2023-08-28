#!/usr/bin/env ruby

require_relative './common.rb'

def read_meta_file(fname)
  File.open(fname) do |f|
    cmd_line = f.gets
    raise unless /\Acommand:\s*(.*)\z/ =~ cmd_line.chomp
    cmd = $1
    desc_line = f.gets
    raise unless /\Adescription:\s*(.*)\z/ =~ desc_line.chomp
    desc = $1
    return [cmd, desc]
  end
end

def main(fin = $stdin, fout = $stdout)
  env_d = read_str("test_env")
  res_zip = read_str('./env_tmp_res.zip')

  t = EnvTree.new(env_d)

  Dir.mkdir(t.res_d)
  Dir.mkdir(t.out_d)
  exec("unzip #{res_zip} -d #{t.res_d}")

  meta_file = t.pro_d + "/metadata"
  meta_cmd, meta_desc = read_meta_file(meta_file)
  fout.puts meta_cmd
  meta_cmd.gsub!(/\$input/, t.in_d)
  meta_cmd.gsub!(/\$output/, t.out_d)
  meta_cmd.gsub!(/\$program/, t.pro_d)
  fout.puts meta_cmd
  fout.puts meta_desc
  exec(meta_cmd)
end

main()
