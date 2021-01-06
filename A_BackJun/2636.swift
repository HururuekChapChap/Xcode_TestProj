import Foundation

var map : [[Int]] = []
var w : Int = 0
var h : Int = 0

func input(){
    
    let wh = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
    
    w = wh[1]
    h = wh[0]
    
    for _ in 0..<h{
        let input = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
        map.append(input)
    }
    
}

var visited : [[Bool]] = []
var change : [(x : Int , y : Int)] = []

func DFS(_ x : Int, _ y : Int){
    
    let UD : [Int] = [1,-1,0,0]
    let LR : [Int] = [0,0,1,-1]
    
    for i in 0..<4{
        
        let nextX = x + LR[i]
        let nextY = y + UD[i]
        
        if (0..<w).contains(nextX) && (0..<h).contains(nextY) {
            
            if !visited[nextY][nextX] {
                visited[nextY][nextX] = true
                
                if map[nextY][nextX] == 1 {
                    
                    if map[nextY][nextX - 1] == 0 || map[nextY][nextX + 1] == 0 || map[nextY-1][nextX] == 0 || map[nextY+1][nextX] == 0 {
                        change.append((nextX , nextY))
                    }
                    
                }
                else{
                    DFS(nextX , nextY)
                }
            }
            
        }
        
    }
    
}

func main(){
    input()
    var cnt = 0
    var cheez = 0
    
    while true {
    
    visited = Array(repeating : Array(repeating : false , count : w), count : h)
    visited[0][0] = true
    change = []
    DFS(0,0)
    
    if change.isEmpty {
        print(cnt)
        print(cheez)
        return
    }
    
    cnt += 1
    cheez = map.flatMap({$0}).filter({$0 == 1}).count
    for item in change{
        
        map[item.y][item.x] = 0
        
    }
//
//    for ele in map{
//        print(ele)
//    }
//        print()
//
    }

    
}

main()


