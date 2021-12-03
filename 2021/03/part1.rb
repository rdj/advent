#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

counts = []

$lines.each do |line|
  (0...line.length).each do |i|
    if counts[i].nil?
      counts[i] = 0
    end
    counts[i] += line[i].to_i
  end
end

gamma = []
epsilon = []

(0...counts.length).each do |i|
  if counts[i] > $lines.length/2
    gamma.push(1)
    epsilon.push(0)
  else
    gamma.push(0)
    epsilon.push(1)
  end
end

puts gamma.join('').to_i(2) * epsilon.join('').to_i(2)
