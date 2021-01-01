import Foundation

var cnt = 1
var input : [Int] = [10,20,28]

while true{
    
    input = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
        if input.filter({$0 == 0}).count == 3 {
            break
        }
        
    let day = input[2] / input[1]
    let left = input[2] % input[1]
    var restDay = day * input[0]
    
    if left <= input[0]{
        restDay += left
    }
    else{
        restDay += input[0]
    }

    print("Case \(cnt): \(restDay)")
    cnt += 1
}
