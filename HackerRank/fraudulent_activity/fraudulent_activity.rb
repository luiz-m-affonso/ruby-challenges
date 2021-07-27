#!/bin/ruby

require 'json'
require 'stringio'

def activity_notifications(expenditure, d, n)
  return 0 if d > n
  counter = Array.new 201, 0
  count = 0

  expenditure.each_with_index do |expense, expense_index|
    if expense_index >= d
      # Enough data to evalutate
      if d.odd?
        median = counter.find_index { |x| x >= (d / 2.0).ceil }
      else
        prev = nil
        counter.each_with_index do |c, i|
          if c > d / 2
            median = prev.nil? ? i : (prev + i) / 2.0
            break
          elsif c == d / 2
            prev ||= i
          end
        end
      end

      count += 1 if expense >= 2 * median

      removed_expense = expenditure[expense_index - d]

      if expense > removed_expense
        removed_expense.upto(expense - 1) { |i| counter[i] -= 1 }
      elsif expense < removed_expense
        expense.upto(removed_expense - 1) { |i| counter[i] += 1 }
      end
    else
      # Still collecting spending data
      expense.upto(200) { |i| counter[i] += 1 }
    end
  end

  count
end
fptr = File.open(ENV['OUTPUT_PATH'], 'w')

nd = gets.rstrip.split

n = nd[0].to_i

d = nd[1].to_i

expenditure = gets.rstrip.split(' ').map(&:to_i)

result = activity_notifications(expenditure, d, n)

fptr.write result
fptr.write "\n"

fptr.close
