/*
 Find Maximum sum subarray
 ex) [-2, 1, -3, 4, -1, 2, 1, -5, 4] ->  [4, -1, 2, 1]
 
 solution : Kadane's Alorithm
 Time complexity is O(n)
 */

import Foundation

public class MaximumSumSubarray {
    public class func run() {
        // test1
        let arr = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
        let subArr = findMaximumSumSubarray(arr)
        print("== Test 1 == ")
        print(arr)
        print(subArr)
        
        // test2
        let array = generateNumArray(size: 10)
        let subArray = findMaximumSumSubarray(array)
        print("== Test 2 == ")
        print(array)
        print(subArray)
    }
    
    class func findMaximumSumSubarray(_ array: [Int]) -> [Int]{
        var result = [Int]()
        
        var sum = 0
        var index = 0
        var subArrSize = 0
        
        var maxSum = 0
        var maxIndex = 0
        var maxSubArrSize = 0
        
        for (i, value) in array.enumerated() {
            let newSum = sum + value
            if newSum < value {
                sum = value
                index = i
                subArrSize = 1
            } else {
                sum = newSum
                subArrSize += 1
                
                if sum > maxSum {
                    maxSum = sum
                    maxIndex = index
                    maxSubArrSize = subArrSize
                }
            }
        }
        
        print("sum : \(maxSum) , index: \(maxIndex), size: \(maxSubArrSize)")
        
        result.append(contentsOf: array[maxIndex...(maxIndex + maxSubArrSize - 1)])
        
        return result
    }
    
    class func generateNumArray(size: Int) -> [Int] {
        var array = [Int]()
        if size < 1 {
            return array
        }
        
        while array.count != size {
            array.append(Int.random(in: -20...20))
        }
        
        return array
    }
}
