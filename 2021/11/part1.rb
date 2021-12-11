#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp).map(&:chars).map{|r| r.map(&:to_i)}

class Octopuses
  def initialize(lines)
    @grid = lines.dup
    @nflashes = 0
  end

  def nrows
    @grid.length
  end

  def ncols
    @grid.first.length
  end

  def get(r,c)
    @grid[r][c]
  end

  def inc(r, c)
    if !self.frozen?(r,c)
      @grid[r][c] += 1
    end
  end

  def freeze(r,c)
    @grid[r][c] = nil
  end

  def frozen?(r,c)
    @grid[r][c].nil?
  end

  def all_frozen?
    self.foreach do |r,c|
      if !self.frozen?(r,c)
        return false
      end
    end
    return true
  end

  def unfreeze(r,c)
    if self.frozen?(r,c)
      @grid[r][c] = 0
    end
  end

  def flash?(r,c)
    !self.frozen?(r,c) && @grid[r][c] > 9
  end

  def get_adjacents(r,c)
    rows = [-1, 0, 1].map{|n| n + r}
    cols = [-1, 0, 1].map{|n| n + c}
    rows.product(cols).filter{|r,c| r >= 0 && c >=0 && r < self.nrows && c < self.ncols}
  end

  def foreach
    (0...self.nrows).each do |r|
      (0...self.ncols).each do |c|
        yield r,c
      end
    end
  end

  def increase_energy
    self.foreach do |r,c|
      if !self.frozen?(r,c)
        self.inc(r,c)
      end
    end
  end

  def has_flashes?
    self.foreach do |r,c|
      if self.flash?(r,c)
        return true
      end
    end
    return false
  end

  def handle_flashes
    self.foreach do |r,c|
      if self.flash?(r,c)
        @nflashes += 1
        self.freeze(r,c)
        self.get_adjacents(r,c).each do |ar, ac|
          self.inc(ar, ac)
        end
      end
    end
  end

  def cleanup_flashes
    self.foreach do |r,c|
      self.unfreeze(r,c)
    end
  end

  def print
    @grid.each do |row|
      puts row.map{|n| n.nil? ? '-' : n.to_s}.join("")
    end
  end

  def run_step
    self.increase_energy
    while self.has_flashes?
      self.handle_flashes
    end
    if self.all_frozen?
      raise "all frozen"
    end
    self.cleanup_flashes
  end

  def flash_count
    @nflashes
  end
end

octs = Octopuses.new($lines)
(0...).each do |n|
  puts "Beginning step #{n+1}"
  octs.run_step
end

puts octs.flash_count
