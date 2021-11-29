#!/usr/bin/env ruby

lines = $stdin.readlines
lines = lines.map(&:chomp).map(&:to_i)

while m = lines.pop
  lines2 = lines.dup
  while n = lines2.pop
    lines2.each do |p|
      if 2020 == m + n + p
        puts "#{m} * #{n} + #{p} = #{m * n * p}"
      end
    end
  end
end
