require_relative './common.rb'

# p, a' --> f

C = Common

n, mp, mr = [C::N, C::MP, C::MR]

p, a = C.read_csv_files(ARGV)

a0, a1 = Common.o2pr(a)

pi = [p, (0...n).to_a].transpose.sort.transpose[1]
a1 = [pi, a1].transpose.sort.transpose[1]

f = a1.map do |a1_i|
  a1_i.map do |a1_ij|
    a1_ij == '*' ? rand(C::C) : a1_ij
  end
end

C.write_csv(f)
