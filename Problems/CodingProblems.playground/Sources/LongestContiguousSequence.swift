import Foundation

/*
 * Write a function that takes two users' browsing histories as input and
 * returns the longest contiguous sequence of URLs that appear in both.
 * For example
 * user1 = ['/home', '/register', '/login', '/user', '/one', '/two']
 * user2 = ['/home', '/red', '/login', '/user', '/one', '/pink']
 * You should return the following: ['/login', '/user', '/one']
 *
 * Time complexity is O(n^2), Space complexity is O(n^2)
 */
public class LongestContiguousSequence {
    public class func run() {
        let sequence_1 = ["/home", "/register", "/login", "/user", "/one", "/two"]
        let sequence_2 = ["/home", "/red", "/login", "/user", "/one", "/pink"]
        
        let subSequence = findSequence(sequence_1, sequence_2)
        print("first : \(sequence_1)")
        print("second: \(sequence_2)")
        print("answer: \(subSequence)")
    }
    
    class func findSequence(_ first: [String], _ second: [String]) -> [String] {
        var result = [String]()
        
        var cache = [[Int]]()
        var longestSize = 0
        var index_i = 0
        var index_j = 0
        
        // first -> index i, second -> index j
        //
        // i/j          0   "/home"   "/red"   "/login"   .   .   .
        //  0           0       0       0           0
        //  "/home"     0       1       0           0
        //  "/register" 0       0       0           0
        //  "/login"    0       0       0           1
        //  .
        for i in 0...first.count {
            cache.append([Int]())
            for j in 0...second.count {
                
                
                if i == 0 || j == 0 {
                    cache[i].append(0)
                } else {
                    if first[i - 1] == second[j - 1] {
                        cache[i].append(cache[i - 1][j - 1] + 1)
//                        cache[i][j] = cache[i - 1][j - 1] + 1
                        
                        if cache[i][j] > longestSize {
                            longestSize = cache[i][j]
                            index_i = i
                            index_j = j
                        }
                    } else {
                        cache[i].append(0)
                    }
                }
                
            }
        }
        
        for index in 0..<longestSize {
            result.append(first[index_i - longestSize + index])
        }
        
        return result
    }
}


