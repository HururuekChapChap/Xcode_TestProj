import Foundation

var inputList : [[String]] = []

func input(){
    let N = Int(readLine()!)!
    for _ in 0..<N{
        let input = readLine()!.components(separatedBy: " ").map({String($0)})
        inputList.append(input)
    }
}

func main(){
    
    input()
    
    for ele in inputList{
        
        var answer : [String] = []
        
        for inside in ele{
            answer.append(change(inside)+" ")
        }
        
        print(answer.joined())
        
    }
    
}

func change(_ inside : String) -> String {
    
    var temp = Array(inside).map({String($0)})
    var start = 0
    var end = temp.count - 1
    
    while start <= end{
        
        let box = temp[start]
        temp[start] = temp[end]
        temp[end] = box
        
        start += 1
        end -= 1
    }
    
    return temp.joined()
    
}

main()
