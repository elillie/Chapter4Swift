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


var A = [-3, 5, 2, 7, -3, -5, 6, 2, -7, -2, 1, 1, 8, -4, -3, 8, 14]

let result = findMaximumSubarray(A, 0, A.count-1)
println(result.low)
println(result.high, result.sum)



