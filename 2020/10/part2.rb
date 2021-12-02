#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp).map{|s| s.to_i(10)}

$lines.sort!
mine = $lines.max + 3
$lines.unshift(0)
$lines.push(mine)

diffs = []
(1...$lines.length).each do |i|
  diffs.push($lines[i] - $lines[i-1])
end

runlengths = []
cur = 0
diffs.each do |d|
  case d
  when 1
    cur += 1
  when 3
    if cur > 0
      runlengths.push(cur)
      cur = 0
    end
  end
end

gaps = runlengths.map{|n| n - 1}.filter{|n| n > 0}
puts $lines.map{|s| sprintf("%02d", s)}.join(' ')
puts '   ' + diffs.map{|s| sprintf("%02d", s)}.join(' ')
choices = gaps.map{|g| g == 3 ? 7 : 2 **g}
pp choices
pp choices.reduce(1){ |p, n| p *= n }
