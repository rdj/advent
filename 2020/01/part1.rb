#!/usr/bin/env ruby

lines = $stdin.readlines
lines = lines.map(&:chomp).map(&:to_i)

while m = lines.pop
  lines.each do |n|
    if 2020 == m + n
      puts "#{m} * #{n}  = #{m * n}"
    end
  end
end
