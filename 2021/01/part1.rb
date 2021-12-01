#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp).map(&:to_i)

incs = 0
(1...$lines.length).each do |i|
  prev = $lines[i - 1]
  cur = $lines[i]
  if cur > prev
    incs += 1
    puts "#{$lines[i]} (increased #{cur} > #{prev}) #{incs}"
  else
    puts "#{$lines[i]} (decreased)"
  end
end
puts incs
