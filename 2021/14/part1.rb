#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

template = $lines.shift.chars
$lines.shift

def get_counts(template)
  counts = {}
  template.uniq.each do |c|
    counts[c] = template.count(c)
  end
  counts
end

rules = {}
while line = $lines.shift
  pair, ins = line.match('([A-Z]{2}) -> ([A-Z])').captures
  rules[pair] = ins
end
#pp rules

#puts "Template #{template.join("")}"
4.times.each do |step|
  after = []
  (0...template.length-1).each do |i|
    pair = template[i,2]
    after.push pair.first
    if ins = rules[pair.join]
      after.push ins
    end
  end
  after.push template.last
  template = after
  puts "#{template.length} : #{template.join}"
#  pp get_counts(template)
end

pp counts = get_counts(template)

sorted = counts.to_a.sort{|a,b| a[1] <=> b[1]}


puts sorted.last.last - sorted.first.last
