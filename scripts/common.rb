#!/usr/bin/env ruby

class Common
  # number of rows
  N = 10 ** 5
  #N = 10 ** 3
  # number of columns for P
  #MP = 6 # pre
  MP = 8 # main
  # number of columns for R
  MR = 10
  # number of categories. all values must be in [0, C)
  C = 10
  # number of teams
  T = 15
  #T = 5
  # teams that did not submit data in anonymization phase
  ANO_NO_SUBMISSION = ['07', '13']

  # number  of columns for A and O
  MA = MP + MR

  class << self
    
    def o2pr(o)
      p = o.map{|oi| oi[0, MP]}
      r = o.map{|oi| oi[MP, MR]}
      [p, r]
    end
    
    def pr2o(p, r)
      n = p.size
      (0...n).map{|i| p[i] + r[i]}
    end


    ## csv io
    def read_csv(fin = $stdin, head = false)
      a = []
      while line = fin.gets
        a << line.split(',',-1).map(&:strip)
      end
      a
    end

    def read_csv_file(fname, head = false)
      File.open(fname) do |fin|
        return read_csv(fin, head)
      end
    end

    def read_csv_files(fnames, head = false)
      fnames.map{|fname| read_csv_file(fname, head)}
    end


    def write_csv(a, fout = $stdout, head = nil)
      fout.puts head.join(',') if head
      fout.puts a.map{|ai| ai.join(',')}
    end
    
    def write_csv_file(a, fname, head = nil)
      File.open(fname, 'w') do |fout|
        write_csv(a, fout, head)
      end
    end

  end # class << self

end # class Common


class FormatChecker
  # n: number of rows
  # m: number of columns
  # c: number of categories
  # allow_star: flag whether to allow asterisks
  def initialize(n, m, c, allow_star = true)
    @n, @m = [n, m]
    v = {}
    c.times{|i| v[i.to_s] = true}
    v['*'] = true if allow_star
    @valid = v
  end

  def _check_row(s)
    return "not a string" unless s
    a = s.chomp.split(',',-1)
    return "wrong number of columns" unless a.size == @m
    a.each_with_index do |aj, j|
      return "col #{j+1}: " + aj unless @valid[aj]
    end
    return nil
  end
  
  # returns | nil            if passed test,
  #         | error message  otherwise
  def check(fin)
    @n.times do |i|
      r = _check_row(fin.gets)
      return "line #{i+1}: " + r if r
    end
    return "too many lines" if fin.gets
    return nil
  end

end # class FormatChecker


class CheckX
  A = [Common::N, Common::MA, Common::C, true]
  R = [Common::N, Common::MR, Common::C, false]
  F = R
  def self._check_x_file(file, params)
    File.open(file) do |fin|
      res = FormatChecker.new(*params).check(fin)
      raise res if res
    end
  end
  def self.check_a_file(file)
    _check_x_file(file, A)
  end
  def self.check_f_file(file)
    _check_x_file(file, F)
  end
  def self.check_r_file(file)
    _check_x_file(file, R)
  end
end # class CheckX


class GenMat

  def initialize(n, m, c, seed = 0)
    @n, @m, @c, @seed = [n, m, c, seed]
    @r = Random.new(@seed)
  end
  
  def _rand(x)
    @r.rand(x)
  end
  
  def _shuffle!(a)
    (a.size - 1).downto(1) do |i|
      j = _rand(i + 1)
      a[i], a[j] = [a[i], a[j]] unless i == j
    end
  end
  
  def _gen_cell()
    _rand(@c)
  end
  
  def _gen_row()
    (0...@m).map{ _gen_cell() }
  end
  
  def _gen_mat()
    a = (0...@n).map{ _gen_row() }
    _shuffle!(a)
    a
  end
  
  def _add(x, y)
    (x + y) % @c
  end
  
  def _add_row(a, b)
    (0...a.size).map{|i| _add(a[i], b[i])}
  end
  
  def _add_mat(a, b)
    (0...a.size).map{|i| _add_row(a[i], b[i])}
  end
  
  def gen()
    @r = Random.new(@seed)
    _add_mat(_gen_mat(), _gen_mat())
  end

end # class GenMat


class GenR

  def self.gen(seed_file)
    File.open(seed_file) do |f|
      raise unless line = f.gets
      raise unless /\A(0|[1-9]\d*)\z/ =~ line.chomp
      seed = $&.to_i
      g = GenMat.new(Common::N, Common::MR, Common::C, seed)
      g.gen()
    end
  end

end # class GenR


class Scores
  class << self

    def _hamming_dist_ary(a, b)
      n = a.size()
      (0...n).map{|i| a[i] == b[i] ? 0 : 1}.sum
    end

    def _hamming_dist_mat(a, b)
      n = a.size()
      (0...n).map{|i| _hamming_dist_ary(a[i], b[i])}.sum
    end

    def utility(o, a)
      n_total = o.size * o[0].size
      n_diff = _hamming_dist_mat(o, a)
      raw_score = n_total - n_diff
      normalized_score = raw_score.to_f / n_total
      [normalized_score, raw_score]
    end

    def attack(r, f)
      n_total = r.size * r[0].size
      n_diff = _hamming_dist_mat(r, f)
      raw_score = n_total - n_diff
      normalized_score = raw_score.to_f / n_total
      [normalized_score, raw_score]
    end

  end # class << self
end # class Scores
