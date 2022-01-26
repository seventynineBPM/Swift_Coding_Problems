/*
 * Coin Changing Problem
 * Minimum Number of Coins to Get Total
 *
 *        +---+---+---+---+---+---+---+---+---+---+---+---+---+
 * (denom)|   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11|
 *        +---+---+---+---+---+---+---+---+---+---+---+---+---+
 *    (1) | 0 | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11|
 *        +---+---+---+---+---+---+---+---+---+---+---+---+---+
 *    (5) | 1 | 0 | 1 | 2 | 3 | 4 | 1 | 2 | 3 | 4 | 5 | 2 | 3 |
 *        +---+---+---+---+---+---+---+---+---+---+---+---+---+
 *    (6) | 2 | 0 | 1 | 2 | 3 | 4 | 1 | 1 | 2 | 3 | 4 | 2 | 2 |
 *        +---+---+---+---+---+---+---+---+---+---+---+---+---+
 *    (8) | 3 | 0 | 1 | 2 | 3 | 4 | 1 | 1 | 2 | 1 | 2 | 2 | 2 |
 *        +---+---+---+---+---+---+---+---+---+---+---+---+---+
 * Minimum Coins = 2 , (6 * 1 + 5 * 1)
 * Time O(nm), space O(nm)
 */
import Foundation

public class CoinChanging {
    public class func run() {
        let coins = [1,5,6,8]
        let total = 11
        
        let minCount = minimumCoins(coins: coins, total: total)
        print("Minimum Coins count : \(minCount.coinCount)")
        printDP(dp: minCount.dp)
        print("change coins : \(chanages(coins: coins, total: total, dp: minCount.dp))")
    }
    
    class func minimumCoins(coins :[Int], total :Int) -> (coinCount: Int, dp : [[Int]]) {
        var count = 0
        var dp = initDP(colomn: coins.count, row: total + 1)
        
        if coins.count < 1 || total < 1 { return (count, dp) }
        if coins.filter({ $0 < 1 }).count > 0 { return (count, dp) }
        
        for i in 0..<coins.count {
            for j in 0...total {
                let quotient = j / coins[i]
                let rest = j % coins[i]
                if i == 0 {
                    dp[i][j] = quotient
                } else {
                    
                    let current = quotient + dp[i - 1][rest]
                    let last = dp[i - 1][j]
                    current < last ? (dp[i][j] = quotient + dp[i - 1][rest]) : (dp[i][j] = last)
                }
            }
        }
        
        count = dp[coins.count - 1][total]
        
        return (count, dp)
    }
    
    class func chanages(coins :[Int], total :Int,dp :[[Int]]) -> [Int:Int] {
        var i = dp.count - 1
        var j = dp.first?.count ?? 0
        if j > 0 { j = j - 1}
        
        var change = [Int:Int]()
        
        var min = dp[i][j]
        while j > 0 {
            if dp[i - 1][j] == min {
                i = i - 1
            } else {
                j = j - coins[i]
                min = min - 1
               
                change[coins[i]] = (change[coins[i]] ?? 0) + 1
            }
        }
        return change
    }
    
    class func initDP(colomn: Int, row :Int) -> [[Int]] {
        var dp = [[Int]]()
        var oneRow = [Int]()
        (0..<row).forEach{ _ in oneRow.append(0) }
        (0..<colomn).forEach{ _ in
            dp.append(oneRow)
        }
        return dp
    }
    
    class func printDP(dp :[[Int]]) {
        print("[")
        dp.forEach{ print("  \($0)")}
        print("]")
    }
}
