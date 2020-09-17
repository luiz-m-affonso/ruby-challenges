#!/bin/ruby

require 'json'
require 'stringio'

# Complete the activityNotifications function below.
def activity_notifications(expenditure, d, n)
  return 0 if d > n
  # Assign Array in variable counter_activity_notifications
  counter_activity_notifications = Array.new 201, 0
  activity_notifications_count = 0

  # Calling expenditure with method each_with_index it receive arguments activity_expense and index
  expenditure.each_with_index do |activity_expense, index|
    if index >= d
      # Validate integers d and assign counter_activity_notifications with find_index method for array to variable median.
      if d.odd?
        median = counter_activity_notifications.find_index { |x| x >= (d / 2.0).ceil }
      else
        previous = nil
        counter_activity_notifications.each_with_index do |c, i|
          if c > d / 2
            median = previous.nil? ? i : (previous + i) / 2
          elsif c == d / 2
            previous ||= i
          end
        end
      end

      activity_notifications_count += 1 if activity_expense >= 2 * median

      activity_remove_expense = expenditure[index - d]

      if activity_expense > activity_remove_expense
        activity_remove_expense.upto(activity_expense - 1) { |i| counter_activity_notifications[i] -= 1 }
      elsif activity_expense < activity_remove_expense
        activity_expense.upto(activity_remove_expense - 1) { |i| counter_activity_notifications[i] += 1 }
      end
    else
      # Collecting Spending Data with activity_expense with argument counter_activity_notifications
      activity_expense.upto(200) { |i| counter_activity_notifications[i] += 1 }
    end
  end
  # Calling activity notifications count
  activity_notifications_count
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
