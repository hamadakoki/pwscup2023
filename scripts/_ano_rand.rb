require_relative 'common.rb'

def dp(x)
  $stderr.puts x.inspect
end

C = Common

can = (0...C::C).to_a + ['*']

o = C.read_csv()
o = o.map{|ai| ai.map(&:to_i)}

a = o.map do |oi|
  oi.map do |oij|
    rand(10) == 0 ? can.sample : oij
  end
end

C.write_csv(a)
