def exec(cmd)
  $stdout.puts cmd
  $stdout.puts `#{cmd}`
end

def _exec(cmd)
  $stdout.puts cmd
end

def read_str(dval = nil)
  r = ARGV.shift
  r ? r : dval
end

class EnvTree
  attr_reader :env_d, :in_d, :out_d, :pro_d, :ref_d, :res_d
  def initialize(env_dir)
    @env_d = env_dir
    @in_d = @env_d + "/input"
    @out_d = @env_d + "/output"
    @pro_d = @env_d + "/program"
    @ref_d = @in_d + "/ref"
    @res_d = @in_d + "/res"
  end
end # class EnvTree
