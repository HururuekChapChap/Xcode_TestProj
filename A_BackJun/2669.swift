import Foundation

var map : [[Bool]] = Array(repeating: Array(repeating: true, count: 101), count: 101)
var inputList : [[Int]] = []

print("Insert")
for _ in stride(from: 0, to: 4, by: 1){
    let input = readLine()!.components(separatedBy: " ")
    let change = input.map { (ele) -> Int in
        return Int(ele)!
    }
    inputList.append(change)
}

for element in inputList{
    
    for y in element[1]..<element[3]{
        for x in element[0]..<element[2]{
            map[y][x] = false
        }
    }
    
}

let answer = map.flatMap { (list) -> [Bool] in
    return list
}.filter { (item) -> Bool in
    return item == false
}.count

print(answer)
