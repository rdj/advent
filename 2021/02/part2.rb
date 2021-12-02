#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

horz = 0
depth = 0
aim = 0

$lines.each do |s|
  dir, arg = /^(\S+) (\d+)$/.match(s).captures
  n = arg.to_i
  case dir
  when 'forward'
    horz += n
    depth += aim * n
  when 'down'
    aim += n
  when 'up'
    aim -= n
  end
end

puts horz * depth
