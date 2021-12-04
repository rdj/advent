#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:strip)#.map{|s| s.to_i(10)}

draws = $lines.shift.split(',').map(&:to_i)

class Board
  class Entry
    def initialize(n)
      @n = n
      @marked = false
    end

    def num
      @n
    end

    def mark
      @marked = true
    end

    def marked?
      @marked
    end

    def to_s
      mark = " "
      if self.marked?
        mark = "*"
      end
      s = mark + sprintf("%2d", num.to_s) + mark
    end
  end

  def initialize
    @rows = []
  end

  def add_row(row)
    @rows.push(row.split(/\s+/).map{|s| Entry.new(s.to_i)})
  end

  def base_score
    @rows.flatten.filter{|b| !b.marked?}.map(&:num).sum
  end

  def cols
    @rows.first.zip(*@rows[1..])
  end

  def mark(n)
    @rows.flatten.filter{|e| e.num == n}.map(&:mark)
  end

  def winning?
    @rows.any?{|r| r.all?{|e| e.marked?}} || self.cols.any?{|c| c.all?{|e| e.marked?}}
  end

  def to_s
    @rows.map{|r| r.map(&:to_s).join(" ")}.join("\n")
  end
end

boards = []
$lines.each do |line|
  if line.empty?
    boards.push(Board.new())
  else
    boards.last.add_row(line)
  end
end

drawn = nil
while boards.none?(&:winning?)
  drawn = draws.shift
  pp "Drew #{drawn}"
  boards.each{ |b| b.mark(drawn) }
end

winner = boards.filter(&:winning?).first
puts winner.to_s
pp winner.base_score
pp winner.base_score * drawn
