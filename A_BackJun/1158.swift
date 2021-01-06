import Foundation

func main(){
    let input = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
    var list = Array(1...input[0])
    
    var flag = 0
    var answer : [Int] = []
    while !list.isEmpty {
        
        var next = flag + input[1] - 1
        
        if next >= list.count {
            next = next % list.count
        }
        
        flag = next
        
        answer.append(list.remove(at: next))
    }
    
    print("<" , terminator : "")
    for index in 0..<answer.count - 1 {
        print("\(answer[index]),", terminator : " ")
    }
    print("\(answer[answer.count - 1])>")
}

main()
