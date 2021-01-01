import Foundation

func main(n : Int, m : Int, input : [[Int]]){
        
    var tempMap = input
    
    var oneCnt = input.flatMap { (list) -> [Int] in
        return list
    }.filter({$0 == 1}).count
    
    var answer = 0
    
    while oneCnt > 0 {
    
    typealias loc = (x:Int, y : Int)
    var cntMap : [[Int]] = Array(repeating: Array(repeating: 0, count: m), count: n)
    
    var queue : [loc] = [(0,0)]
    tempMap[0][0] = -1
    let LR : [Int] = [1,-1,0,0]
    let UD : [Int] = [0,0,1,-1]
    
    while !queue.isEmpty{
        
        let x = queue.last!.x
        let y = queue.last!.y
        
        queue.removeLast()
        
        for i in 0..<4{
            
            let nextX = x + LR[i]
            let nextY = y + UD[i]
            
            if (0..<m).contains(nextX) && (0..<n).contains(nextY){
                
                if cntMap[nextY][nextX] != -1 {
                
                if tempMap[nextY][nextX] == 1 {
                    cntMap[nextY][nextX] += 1
                }
                else{
                    cntMap[nextY][nextX] = -1
                    queue.insert(loc(nextX, nextY), at: 0)
                }
                    
                }
                
            }
            
        }
  
    }
    
    for (yindex, y) in cntMap.enumerated(){
        for (xindex , x) in y.enumerated() {
            if x >= 2 {
                tempMap[yindex][xindex] = 0
            }
        }
    }
        
    oneCnt = tempMap.flatMap { (list) -> [Int] in
            return list
        }.filter({$0 == 1}).count
    
        answer += 1
    
    }
    
    print(answer)
    
}

//세로
var N : Int = 8
//가로
var M : Int = 9

var input : [[Int]] = [

    [0 ,0 ,0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 1, 0, 0, 0, 0],
    [0, 0, 0, 1, 1, 0, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 1, 0, 0],
    [0, 0, 1, 1, 0, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]

]

let test = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
N = test[0]
M = test[1]
input = []

for _ in 0..<N{
    
    let temp = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
    input.append(temp)
    
}


main(n: N, m: M, input: input)
