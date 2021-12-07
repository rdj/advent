#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

crabs = Hash.new(0)

$lines.first.split(',').map(&:to_i).each do |n|
  crabs[n] += 1
end

min = crabs.keys.min
max = crabs.keys.max

finals = {}
lowest = nil
(min..max).each do |m|
  finals[m] = crabs.map{|n,t|
    diff = (n - m).abs
    total = ((diff + 1) * diff)/2
    total * t}.sum
  if lowest.nil?
    lowest = finals[m]
  else
    lowest = [finals[m], lowest].min
  end
end

puts lowest
