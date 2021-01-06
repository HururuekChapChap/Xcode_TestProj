import Foundation

var realmap : [[Int]] = [

    [1,0,1,0],
    [0,4,2,0],
    [0,0,9,0],
    [0,0,0,0],
    
]
var answer = 0

func input(){
    realmap = []
    let N = Int(readLine()!)!
    
    for _ in 0..<N{
        let input = readLine()!.components(separatedBy: " ").map({Int(String($0))!})
        realmap.append(input)
    }
    
}

func main(){
    
    input()
    
    var shark = 2
    var x = 0
    var y = 0
    var plus = 0
    var eats = 0
    
    repeat {
    
    for (yindex, yele) in realmap.enumerated(){
        for (xindex, xele) in yele.enumerated(){
            if xele == 9 {
                    x = xindex
                    y = yindex
            }
        }
    }
        
    plus = searchBFS(shark: shark, x: x, y: y)
        
    eats += plus
        
    if eats == shark {
        shark += 1
        eats = 0
    }
        
//        for ele in realmap{
//            print(ele)
//        }
//        print()

    }while plus != 0
    
    
    
}

func searchBFS(shark : Int ,x : Int, y : Int) -> Int{
    
    typealias loc = (x:Int, y:Int, cnt : Int)
    var queue : [loc] = [(x,y,0)]
    var visited :[[Bool]] = Array(repeating : Array(repeating: false, count: realmap.count),count :realmap.count)
    visited[y][x] = true
    var fish : [loc] = []
    let UD : [Int] = [1,-1,0,0]
    let LR : [Int] = [0,0,1,-1]
    
    while !queue.isEmpty{
        
        let temp_X = queue.last!.x
        let temp_Y = queue.last!.y
        let temp_cnt = queue.last!.cnt
        queue.removeLast()
        
        for i in 0..<4{
           
            let next_X = temp_X + LR[i]
            let next_Y = temp_Y + UD[i]
            
            if (0..<realmap.count).contains(next_X) && (0..<realmap.count).contains(next_Y){
                
                if visited[next_Y][next_X] == false && realmap[next_Y][next_X] <= shark {
                    
                    visited[next_Y][next_X] = true
                    
                    if realmap[next_Y][next_X] < shark && realmap[next_Y][next_X] != 0{
                        fish.append((next_X , next_Y, temp_cnt + 1))
                    }
                    
                    queue.insert((next_X,next_Y,temp_cnt + 1), at: 0)
                    
                }
                
                
            }
            
        }
    }
    
    //더이상 먹은게 없을 때
    if fish.isEmpty {
        return 0
    }
    else{
    
        let item = fish.sorted { (ele1, ele2) -> Bool in
            
            if ele1.cnt == ele2.cnt{
                
                if ele1.y == ele2.y{
                    return ele1.x < ele2.x
                }
                
                return ele1.y < ele2.y
            }
            
            return ele1.cnt < ele2.cnt
        }.first!
        
        realmap[y][x] = 0
        realmap[item.y][item.x] = 9
        answer += item.cnt
        
    }
    
    return 1
}

main()
print(answer)

