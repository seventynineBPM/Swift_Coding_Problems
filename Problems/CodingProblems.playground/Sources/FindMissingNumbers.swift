import Foundation

/*
 * Daily Coding Problem: [Medium]
 * You are given an unsorted list of 999,000 unique integers,
 * each from 1 and 1,000,000. Find the missing 1000 numbers.
 * What is the computational and space complexity of your solution?
 *
 * Time complexity is O(n), Space complexity is O(n)
 */
public class FindMissingNumbers {
    public class func run() {
        
        var answer = [Int]()
        
        let missingNumbers = findMissingNumbers(generateNumbers(1000, { answer = $0 }))
        print(missingNumbers)
        assert(isEqualArray(missingNumbers, answer), "It is not correct")
    }
    
    static let modulo = 1000000 // 1,000,000
    
    class func findMissingNumbers(_ numbers: [Int]) -> [Int] {
        var result = Array(1...modulo)
        
        numbers.forEach{ result[$0-1] = 0 }
        
        return result.filter{ $0 > 0 }
    }
    
    class func generateNumbers(_ count: Int, _ missingNums: ((_ numbers: [Int]) -> Void)? ) -> [Int] {
        var numbers = Array(1...modulo)
        var removedNum = [Int]()
        
        var generated = 0
        while generated != count {
            let number = Int.random(in: 1...modulo)
            if numbers[number - 1] != 0 {
               numbers[number - 1] = 0
                generated += 1
                removedNum.append(number)
            }
        }
        missingNums?(removedNum)
        
        return numbers.filter{ $0 != 0 }
    }
    
    class func isEqualArray(_ left: [Int], _ right: [Int]) -> Bool {
        if left.count != right.count {
            return false
        }
        
        for (i,value) in left.enumerated() {
            if right[i] != value {
                return false
            }
        }
        
        return true
    }
}
