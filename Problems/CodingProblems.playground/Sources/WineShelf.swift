/*
 * you have N (1, 2, 3, ...., N) wines placed next to each other on a shelf. The price of ith wine is p[i].
 * The price of the wines increase every year. Suppose this is year 1, on year y the price of the ith wine
 * will be: year * price of the wine = y*p[i]. you have to sell exactly one wine per year, starting from
 * this year. Again, on each year, you are allowed to sell only the leftmost or the rightmost wine and you
 * can't rearrange the wines, that means they must stay in same order as they are in the beginning.
 * What is maximum total profit?
 *
 * ex)
 * +---+---+---+---+---+
 * | 2 | 3 | 5 | 1 | 4 |
 * +---+---+---+---+---+
 * 2*1 + 4*2 + 1*3 + 3*4 + 5*5 = 50
 */

import Foundation

public class WineShelf {
    public class func run() {
        let shelf = [2,3,5,1,4]
//        let shelf = [1,4,2,3]
//        let profit = determinProfit(shelf: shelf, left: 0, right: shelf.count - 1, year: 1)
//        print("total profit : \(profit)")
        
        let profit = determinProfit_DP(shelf: shelf)
        print("total profit : \(profit)")
    }
    
    /*
     * solve by recursion.
     * Time complexity O(2^n)
     */
    class func determinProfit(shelf :[Int], left : Int, right: Int, year :Int) -> Int {
        if shelf.count == 0 { return 0 }
        if shelf.count == 1 { return shelf[0] * year }
        if left > right { return 0 }
        
        return max(determinProfit(shelf: shelf, left: left + 1, right: right, year: year + 1) + shelf[left] * year,
                   determinProfit(shelf: shelf, left: left, right: right - 1, year: year + 1) + shelf[right] * year)
        
    }
    
    /*
     * solve by DP
     * Time complexity O(n^2), Space complexity O(n^2)
     */
    class func determinProfit_DP(shelf :[Int]) -> Int {
        var dp = getDPTable(x: shelf.count, y: shelf.count)
//        let profit = determinProfit_DP(shelf: shelf, begin: 0, end: shelf.count - 1, dp: &dp)
//        printDP(dp: dp)
        return determinProfit_DP(shelf: shelf, begin: 0, end: shelf.count - 1, dp: &dp)
    }
    
    class func determinProfit_DP(shelf :[Int], begin: Int, end: Int, dp: inout [[Int]]) -> Int {
        if begin > end { return 0 }
        if dp[begin][end] != -1 { return dp[begin][end] }
        let year = shelf.count - (end - begin + 1) + 1
        
        dp[begin][end] = max(determinProfit_DP(shelf: shelf, begin: begin + 1, end: end, dp: &dp) + shelf[begin] * year,
                             determinProfit_DP(shelf: shelf, begin: begin, end: end - 1, dp: &dp) + shelf[end] * year)
        
        return dp[begin][end]
    }
    
    class func getDPTable(x :Int, y : Int) -> [[Int]] {
        var row = [Int]()
        for _ in 0..<x {
            row.append(-1)
        }
        
        var dp = [[Int]]()
        for _ in 0..<y {
            dp.append(row)
        }
        
        return dp
    }
    
    class func printDP(dp :[[Int]]) {
        dp.forEach {
            print($0)
        }
    }
}
