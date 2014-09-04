//
//  main.swift
//  Chapter4Swift
//
//  Created by Ethan Lillie on 9/1/14.
//  Copyright (c) 2014 Algorithms. All rights reserved.
//

import Foundation

println("Hello, World!")

func findMaxCrossingSubarray(A: [Int], low: Int, mid: Int, high: Int) -> (maxLeft: Int, maxRight: Int, sumTotal: Int) {
    var leftSum = NSIntegerMax
    leftSum = leftSum * -1
    var maxLeft = 0
    var sum = 0
    for i in low...mid {
        sum = sum + A[mid-i]
        if sum > leftSum {
            leftSum = sum
            maxLeft = mid - i
        }
    }
    var rightSum = NSIntegerMax
    rightSum = rightSum * -1
    sum = 0
    var maxRight = 0
    for i in mid + 1...high {
        sum = sum + A[i]
        if sum > rightSum {
            rightSum = sum
            maxRight = i
        }
    }
    return (maxLeft, maxRight, leftSum + rightSum)
}

func findMaximumSubarray(A: [Int], low: Int, high: Int) -> (low: Int, high: Int, sum: Int) {
    if high == low {
        return (low, high, A[low])
    } else {
        var mid:Int = (low + high)/2
        let leftSubarrayDetails = findMaximumSubarray(A, low, mid)
        var leftLow = leftSubarrayDetails.low
        var leftHigh = leftSubarrayDetails.high
        var leftSum = leftSubarrayDetails.sum
        
        let rightSubarrayDetails = findMaximumSubarray(A, mid+1, high)
        var rightLow = rightSubarrayDetails.low
        var rightHigh = rightSubarrayDetails.high
        var rightSum = rightSubarrayDetails.sum
        
        let crossSubarrayDetails = findMaxCrossingSubarray(A, low, mid, high)
        var crossLow = crossSubarrayDetails.maxLeft
        var crossHigh = crossSubarrayDetails.maxRight
        var crossSum = crossSubarrayDetails.sumTotal
        
        if leftSum >= rightSum && leftSum >= crossSum {
            return (leftLow, leftHigh, leftSum)
        } else if rightSum >= leftSum && rightSum >= crossSum {
            return (rightLow, rightHigh, rightSum)
        } else {return (crossLow, crossHigh, crossSum)}
        
    }
}
// exercise 4.1-5, some problems here
func linearFindMaxSubarray(A: [Int], low: Int, high: Int) -> (low: Int, high: Int, sum: Int) {
    
    var start = low
    var end = 0
    var sum = 0
    var sumToIndex = 0
    
    for i in low...high {
        
        sumToIndex += A[i]
        
        if i == low && A[i]>0 {
            end = i
            sum = A[i]
        } else if start == end && A[start] <= 0 {
            start = i
            end = i
            sum = A[i]
            sumToIndex = A[i]
        } else if end == i-1 && A[i] > 0 {
            end = i
            sum += A[i]
        } else if end < i - 1{
            var newStart = 0
            var newSum = 0
            var maxSum = 0
            for j in end + 1...i
            {
                newSum += A[i + end + 1 - j]
                if newSum > maxSum {
                    maxSum = newSum
                    newStart = i + end + 1 - j
                }
            }
            if maxSum > sum && maxSum > sumToIndex {
                sum = maxSum
                start = newStart
                end = i
                sumToIndex = sum
            } else if sumToIndex > sum {
                sum = sumToIndex
                end = i
            }
        }
    }
    return (start, end, sum)
}

var A = [Int]()

for i in 0...220 {
    var randomNum = Int(rand())
    if randomNum % 2 == 0 {
        A.insert(randomNum % 11, atIndex: i)
    } else {
        A.insert(-1 * randomNum % 11, atIndex: i)
    }
}

println(A)

var result = findMaximumSubarray(A, 0, A.count-1)
println(result)

var sum = 0
for i in result.low...result.high {
    sum += A[i]
}
println(sum)

result = linearFindMaxSubarray(A, 0, A.count-1)
println(result)

sum = 0
for i in result.low...result.high {
    sum += A[i]
}
println(sum)

