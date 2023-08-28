#!/usr/bin/env ruby

require_relative './common.rb'

def main(fin = $stdin, fout = $stdout)
  env_d = read_str("test_env")
  pro_zip = read_str('./env_tmp_pro.zip')
  ref_zip = read_str('./env_tmp_ref.zip')

  t = EnvTree.new(env_d)
  
  [t.env_d, t.in_d, t.pro_d, t.ref_d].each do |dir|
    Dir.mkdir(dir)
  end

  exec("unzip #{pro_zip} -d #{t.pro_d}")
  exec("unzip #{ref_zip} -d #{t.ref_d}")
end

main()
