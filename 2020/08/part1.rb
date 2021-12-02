#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map(&:to_i(10))

$acc = 0
cur = 0
seen = []

while 1
  if seen.include? cur
    puts "#{cur}: Infinite Loop!"
    puts "Accumulator #{$acc}"
    exit 1
  end
  seen.append(cur)

  line = $lines[cur]
  instr, arg = /^(nop|acc|jmp) ([+-]\d+)$/.match(line).captures
  puts "#{cur}: #{instr}(#{arg})"
  case instr
  when 'nop'
    cur += 1
  when 'acc'
    $acc += arg.to_i
    cur += 1
  when 'jmp'
    cur += arg.to_i
  end
end
