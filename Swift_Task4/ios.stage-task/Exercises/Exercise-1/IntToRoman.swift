import Foundation

public extension Int {
    
    var roman: String? {
        let romanNumbers = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let intrNumbers = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        var num: Int = self

        guard self > 0  else {
            return nil
        }
        var result = ""
        while (num > 0) {
            for (index, i) in intrNumbers.enumerated() {
                if (i <= num) {
                    result += romanNumbers[index]
                    num -= i
                    break
                }
            }
            
        }
        return result
    }
}
