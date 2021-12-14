#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

template = $lines.shift
$lines.shift # blank line

rules = {}
while line = $lines.shift
  pair, ins = line.match('([A-Z]{2}) -> ([A-Z])').captures
  rules[pair] = [pair[0] + ins, ins + pair[1]]
end

def get_pairs(s)
  (0...s.length - 1).map{|i| s[i,2]}
end

pair_counts = Hash.new(0)

get_pairs(template).each do |p|
  pair_counts[p] += 1
end
extras = pair_counts.values.sum - 1
puts "Gen 0; L=#{pair_counts.values.sum * 2 - extras}"

(40).times.each do |gen|
  old_counts = pair_counts
  pair_counts = Hash.new(0)
  old_counts.dup.each do |pair,count|
    rules[pair].each do |new_pair|
      pair_counts[new_pair] += count
    end
  end
  extras = pair_counts.values.sum - 1
  puts "Gen #{gen + 1}; L=#{pair_counts.values.sum * 2 - extras}"
end

char_counts = Hash.new(0)
pair_counts.each do |pair,count|
  pair.chars.each do |c|
    char_counts[c] += count
  end
end

char_counts[template[0]] -= 1
char_counts[template[-1]] -=1

char_counts.keys.each do |char|
  char_counts[char] /= 2
end

char_counts[template[0]] += 1
char_counts[template[-1]] +=1

sorted = char_counts.to_a.sort{|a,b| a[1] <=> b[1]}
pp sorted
least = sorted.first
least_val = least[1]
most = sorted.last
most_val = most[1]
puts "Least #{least[0]}, n = #{least_val}"
puts "Most  #{most[0]}, n = #{most_val}"
puts "Difference #{most_val - least_val}"
