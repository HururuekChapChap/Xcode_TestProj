import Foundation

typealias table = (school : Int , apple : Int)

var inputs : [table] = []

let N = Int(readLine()!)!
for _ in 0..<N{
    let input = readLine()!.components(separatedBy: " ").map { (ele) -> Int in
        return Int(ele)!
    }
    
    inputs.append(table(input[0] , input[1]))
}

var answer = 0

for element in inputs{
    
    if element.apple < element.school{
        answer += element.apple
    }
    else{
        answer +=  element.apple - (element.apple / element.school) * element.school
    }
    
}

print(answer)

