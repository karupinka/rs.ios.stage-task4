import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        guard newColor < 65536 else { return image }
        guard row >= 0 else { return image }
        guard column >= 0 else { return image }
        
        guard image.count >= 0 else { return image }
        guard row < image.count else { return image }
        guard image[row].count <= 50 else { return image }
        guard column < image[row].count else { return image }
        
        var output = image
        let number = image[row][column]
        guard number >= 0 else { return image }
        var rowTmpBack = row - 1;
        var rowTmpNext = row + 1;
        output[row] = fillWithColorRow(output[row], column, number, newColor)
            
        while rowTmpBack >= 0 {
            output[rowTmpBack] = fillWithColorRow(output[rowTmpBack], column, number, newColor)
            output[rowTmpBack] = fillWithColorRowWithLastRow(image: output[rowTmpBack], imageLast: output[rowTmpBack + 1], newColor: newColor, number: number)
            rowTmpBack -= 1
        }
            
        while rowTmpNext < image.count {
            output[rowTmpNext] = fillWithColorRow(image[rowTmpNext], column, number, newColor)
            output[rowTmpNext] = fillWithColorRowWithLastRow(image: image[rowTmpNext], imageLast: output[rowTmpNext - 1], newColor: newColor, number: number)
            rowTmpNext += 1
        }
    
        return output
    
    }
    
    func fillWithColorRow(_ image: [Int], _ column: Int, _ number: Int, _ newColor: Int) -> [Int] {
        var output = image
        var continueNext = true

        output[column] = newColor

        var columnTmpBack = column - 1;
        var columnTmpNext = column + 1;

        while continueNext {
            if columnTmpBack < 0 {
                continueNext = false
                break
            }
            if number == image[columnTmpBack] {
                output[columnTmpBack] = newColor
                columnTmpBack -= 1
            } else {
                continueNext = false
            }
        }
        
        continueNext = true
        
        while continueNext {
            if columnTmpNext >= image.count {
                continueNext = false
                break
            }
            
            if number == image[columnTmpNext] {
                output[columnTmpNext] = newColor
                columnTmpNext += 1
            } else {
                continueNext = false
            }
        }
    
    return output
    
    }

    func fillWithColorRowWithLastRow(image: [Int], imageLast: [Int], newColor: Int, number: Int) -> [Int] {
        var index = 0
        var output = image
        while index < imageLast.count {
            if imageLast[index] == newColor && output[index] == number {
                output[index] = newColor
            }
            index += 1
        }
    
    return output
    
    }
}
