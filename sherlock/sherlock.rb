#!/bin/ruby

require 'json'
require 'stringio'

# Complete the isValid function below.
def isValid(s)

  counts = Hash.new(0)
  s.split('').each { |elem| counts[elem] += 1 }

  sameRepetitionCount = Hash.new(0)
  counts.each do |elem|
    sameRepetitionCount[elem[1]] += 1
    return 'NO' if sameRepetitionCount.size > 2
  end

  if (sameRepetitionCount.size > 1 && sameRepetitionCount.key(1) != 1)
    if sameRepetitionCount.key(1).nil?
      return 'NO'
    else
      sameRepetitionCount[sameRepetitionCount.key(1) - 1] = sameRepetitionCount.delete sameRepetitionCount.key(1)
      if sameRepetitionCount.size > 1
        return 'NO'
      end
    end
  end

  return 'YES'
end

fptr = File.open(ENV['OUTPUT_PATH'], 'w')

s = gets.to_s.rstrip

result = isValid s

fptr.write result
fptr.write "\n"

fptr.close()
