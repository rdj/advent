#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map(&:to_i(10))


def test_program(lines)
  acc = 0
  cur = 0
  seen = []

  while cur < lines.count
    if seen.include? cur
      return nil
    end
    seen.append(cur)

    line = lines[cur]
    instr, arg = /^(nop|acc|jmp) ([+-]\d+)$/.match(line).captures
    case instr
    when 'nop'
      cur += 1
    when 'acc'
      acc += arg.to_i
      cur += 1
    when 'jmp'
      cur += arg.to_i
    end
  end

  return acc
end

(0...$lines.count).each do |i|

  prog = nil
  if $lines[i].match(/^nop/)
    prog = $lines.dup
    prog[i] = prog[i].sub(/nop/, 'jmp')
  elsif $lines[i].match(/^jmp/)
    prog = $lines.dup
    prog[i] = prog[i].sub(/jmp/, 'nop')
  end

  if !prog.nil?
    result = test_program(prog)
    if !result.nil?
      puts result
      exit 0
    end
  end

  i += 1
end
