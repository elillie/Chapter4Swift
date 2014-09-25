//
//  main.swift
//  Chapter4Swift
//
//  Created by Ethan Lillie on 9/1/14.
//  Copyright (c) 2014 Algorithms. All rights reserved.
//

import Foundation

println("Hello, World!")

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

func squareMatrixMultiply(A: Matrix, B: Matrix) -> (C: Matrix)
{
    let n = A.rows
    var C = Matrix(rows: n, columns: n)
    for i in 0..<n {
        for j in 0..<n {
            C[i,j] = 0
            for k in 0..<n {
                C[i,j] = C[i,j] + A[i,k] * B[k, j]
            }
        }
        
    }
    return C
}
func squareMatrixMultiplyRecursive(A: Matrix, B: Matrix) -> (C: Matrix)
{
    let n = A.rows
    var C = Matrix(rows: n, columns: n)
    if n == 1 {
        C[0,0] = A[0,0]*B[0,0]
    } else {
        var C1 = Matrix(rows: n/2, columns: n/2)
        var C2 = Matrix(rows: n/2, columns: n/2)
        var C3 = Matrix(rows: n/2, columns: n/2)
        var C4 = Matrix(rows: n/2, columns: n/2)
        var A1 = Matrix(rows: n/2, columns: n/2)
        var A2 = Matrix(rows: n/2, columns: n/2)
        var A3 = Matrix(rows: n/2, columns: n/2)
        var A4 = Matrix(rows: n/2, columns: n/2)
        var B1 = Matrix(rows: n/2, columns: n/2)
        var B2 = Matrix(rows: n/2, columns: n/2)
        var B3 = Matrix(rows: n/2, columns: n/2)
        var B4 = Matrix(rows: n/2, columns: n/2)
        
        for i in 0..<n {
            for j in 0..<n {
                if i < n/2 {
                    if j < n/2 {
                        A1[i,j] = A[i,j]
                        B1[i,j] = B[i,j]
                    } else {
                        A2[i,j-n/2] = A[i,j]
                        B2[i,j-n/2] = B[i,j]
                    }
                } else {
                    if j < n/2 {
                        A3[i-n/2,j] = A[i,j]
                        B3[i-n/2,j] = B[i,j]
                    } else {
                        A4[i-n/2,j-n/2] = A[i,j]
                        B4[i-n/2,j-n/2] = B[i,j]
                    }
                }
            }
        }
        let C1a = squareMatrixMultiplyRecursive(A1, B1)
        let C1b = squareMatrixMultiplyRecursive(A2, B3)
        let C2a = squareMatrixMultiplyRecursive(A1, B2)
        let C2b = squareMatrixMultiplyRecursive(A2, B4)
        let C3a = squareMatrixMultiplyRecursive(A3, B1)
        let C3b = squareMatrixMultiplyRecursive(A4, B3)
        let C4a = squareMatrixMultiplyRecursive(A3, B2)
        let C4b = squareMatrixMultiplyRecursive(A4, B4)
        for i in 0..<n/2 {
            for j in 0..<n/2 {
                C1[i,j] = C1a[i,j] + C1b[i,j]
                C2[i,j] = C2a[i,j] + C2b[i,j]
                C3[i,j] = C3a[i,j] + C3b[i,j]
                C4[i,j] = C4a[i,j] + C4b[i,j]
            }
        }
        
        for i in 0..<n {
            for j in 0..<n {
                if i < n/2 {
                    if j < n/2 {
                        C[i,j] = C1[i,j]
                    } else {
                        C[i,j] = C2[i,j-n/2]
                    }
                } else {
                    if j < n/2 {
                        C[i,j] = C3[i-n/2,j]
                    } else {
                        C[i,j] = C4[i-n/2,j-n/2]
                    }
                }
            }
        }
        
    }
    return C
}

func strassenSquareMatrixMultiply(A: Matrix, B: Matrix) -> (C: Matrix)
{
    let n = A.rows
    var C = Matrix(rows: n, columns: n)
    if n == 1 {
        C[0,0] = A[0,0]*B[0,0]
    } else {
        var C1 = Matrix(rows: n/2, columns: n/2)
        var C2 = Matrix(rows: n/2, columns: n/2)
        var C3 = Matrix(rows: n/2, columns: n/2)
        var C4 = Matrix(rows: n/2, columns: n/2)
        var A1 = Matrix(rows: n/2, columns: n/2)
        var A2 = Matrix(rows: n/2, columns: n/2)
        var A3 = Matrix(rows: n/2, columns: n/2)
        var A4 = Matrix(rows: n/2, columns: n/2)
        var B1 = Matrix(rows: n/2, columns: n/2)
        var B2 = Matrix(rows: n/2, columns: n/2)
        var B3 = Matrix(rows: n/2, columns: n/2)
        var B4 = Matrix(rows: n/2, columns: n/2)
        
        var S1 = Matrix(rows: n/2, columns: n/2)
        var S2 = Matrix(rows: n/2, columns: n/2)
        var S3 = Matrix(rows: n/2, columns: n/2)
        var S4 = Matrix(rows: n/2, columns: n/2)
        var S5 = Matrix(rows: n/2, columns: n/2)
        var S6 = Matrix(rows: n/2, columns: n/2)
        var S7 = Matrix(rows: n/2, columns: n/2)
        var S8 = Matrix(rows: n/2, columns: n/2)
        var S9 = Matrix(rows: n/2, columns: n/2)
        var S10 = Matrix(rows: n/2, columns: n/2)
        
        for i in 0..<n {
            for j in 0..<n {
                if i < n/2 {
                    if j < n/2 {
                        A1[i,j] = A[i,j]
                        B1[i,j] = B[i,j]
                    } else {
                        A2[i,j-n/2] = A[i,j]
                        B2[i,j-n/2] = B[i,j]
                    }
                } else {
                    if j < n/2 {
                        A3[i-n/2,j] = A[i,j]
                        B3[i-n/2,j] = B[i,j]
                    } else {
                        A4[i-n/2,j-n/2] = A[i,j]
                        B4[i-n/2,j-n/2] = B[i,j]
                    }
                }
            }
        }
        
        for i in 0..<n/2 {
            for j in 0..<n/2 {
                S1[i,j] = B2[i,j] - B4[i,j]
                S2[i,j] = A1[i,j] + A2[i,j]
                S3[i,j] = A3[i,j] + A4[i,j]
                S4[i,j] = B3[i,j] - B1[i,j]
                S5[i,j] = A1[i,j] + A4[i,j]
                S6[i,j] = B1[i,j] + B4[i,j]
                S7[i,j] = A2[i,j] - A4[i,j]
                S8[i,j] = B3[i,j] + B4[i,j]
                S9[i,j] = A1[i,j] - A3[i,j]
                S10[i,j] = B1[i,j] + B2[i,j]
            }
        }
        
        let P1 = strassenSquareMatrixMultiply(A1, S1)
        let P2 = strassenSquareMatrixMultiply(S2, B4)
        let P3 = strassenSquareMatrixMultiply(S3, B1)
        let P4 = strassenSquareMatrixMultiply(A4, S4)
        let P5 = strassenSquareMatrixMultiply(S5, S6)
        let P6 = strassenSquareMatrixMultiply(S7, S8)
        let P7 = strassenSquareMatrixMultiply(S9, S10)
        
        
        for i in 0..<n/2 {
            for j in 0..<n/2 {
                C1[i,j] = P5[i,j] + P4[i,j] - P2[i,j] + P6[i,j]
                C2[i,j] = P1[i,j] + P2[i,j]
                C3[i,j] = P3[i,j] + P4[i,j]
                C4[i,j] = P5[i,j] + P1[i,j] - P3[i,j] - P7[i,j]
            }
        }
        
        for i in 0..<n {
            for j in 0..<n {
                if i < n/2 {
                    if j < n/2 {
                        C[i,j] = C1[i,j]
                    } else {
                        C[i,j] = C2[i,j-n/2]
                    }
                } else {
                    if j < n/2 {
                        C[i,j] = C3[i-n/2,j]
                    } else {
                        C[i,j] = C4[i-n/2,j-n/2]
                    }
                }
            }
        }

        
    }
    
    
    return C
}

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

//var A = [Int]()
//
//for i in 0...2200 {
//    var randomNum = Int(rand())
//    if randomNum % 2 == 0 {
//        A.insert(randomNum % 11, atIndex: i)
//    } else {
//        A.insert(-1 * randomNum % 11, atIndex: i)
//    }
//}
//
//println(A)
//
//var result = findMaximumSubarray(A, 0, A.count-1)
//println(result)
//
//var sum = 0
//for i in result.low...result.high {
//    sum += A[i]
//}
//println(sum)
//
//result = linearFindMaxSubarray(A, 0, A.count-1)
//println(result)
//
//sum = 0
//for i in result.low...result.high {
//    sum += A[i]
//}
//println(sum)

var A = Matrix(rows: 4, columns: 4)
var B = Matrix(rows: 4, columns: 4)

//A[1,1] = 4
//A[0,1] = 8
//A[0,0] = 3
//
//B[1,1] = 4
//B[0,1] = 8
//B[0,0] = 3

for i in 0...3 {
    for j in 0...3 {
        var aa = arc4random()
        A[i,j] = Double(aa)%10
        aa = arc4random()
        B[i,j] = Double(aa)%10
    }
}


var C = squareMatrixMultiply(A, B)
for i in 0...3 {
    for j in 0...3 {
        println(C[i,j])
    }
}
C = strassenSquareMatrixMultiply(A, B)
for i in 0...3 {
    for j in 0...3 {
        println(C[i,j])
    }
}