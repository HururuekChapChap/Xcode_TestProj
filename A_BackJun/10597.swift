import Foundation

var arr : [String] = []
var totalLen : Int = 0
var sets : Set<String> = []

func main(){
    
    let input = readLine()!
    arr = Array(input).map({String($0)})
    totalLen = arr.count
    
    if arr.count == 1 {
        print("1")
        return
    }
    BFS()
}

func checkIsoverLen(_ maxnum : Int) -> Bool {
    
    var total : Int = 0
    
    if maxnum >= 10 {
        total += (maxnum - 10 + 1) * 2 + 9
    }
    else{
        total += maxnum
    }
    
    if totalLen < total {
        return true
    }
    
    return false
}

func checkIsMulti(_ input : String) -> Bool{
   
    let split = input.components(separatedBy: " ").map({Int(String($0))!})
    let maxValue = split.max()!
    var visited : [Bool] = Array(repeating: false, count : maxValue+1)
    
    if checkIsoverLen(maxValue) {
        return true
    }
    
    //중복되어 있냐
    for item in split{
        
        if visited[item] == false{
            visited[item] = true
        }
        else{
            //중복이다
            return true
        }
    }
    
    //중복이 아니다
    return false
    
}

func checkIsN(_ input : String) -> Bool{
    
    let split = input.components(separatedBy: " ").map({Int(String($0))!})
    let maxValue = split.max()!
    var visited : [Bool] = Array(repeating: false, count : maxValue+1)
    
    //중복되어 있냐
    for item in split{
        
        if visited[item] == false{
            visited[item] = true
        }
        else{
            return false
        }
        
    }
    
    let cnt = visited.filter({$0 == false}).count
//    print(input , cnt)
    return cnt == 1 ? true : false
}

func BFS(){
    
    typealias list = (name : String, inputIndex : Int )
    
    var queue : [list] = [(arr[0],1)]
    sets.insert(arr[0])
    //first Inputs
    let twoSum = arr[0] + arr[1]
    if Int(twoSum)! <= 50{
        sets.insert(twoSum)
        queue.append((twoSum,2))
    }
    
    while !queue.isEmpty {
        
        let name = queue.last!.name
        let inputIndex = queue.last!.inputIndex
   
        queue.removeLast()
        
        //중복이거나 순열보다 길이가 길 경우
        if checkIsMulti(name) {continue}
        
        if inputIndex >= arr.count {
            //check is N 순열
            
            if checkIsN(name) {
                print(name)
                return
            }
            
        }
        else{
            
            var temp = " " + arr[inputIndex]
            
            if arr[inputIndex] != "0"{
                
                if !checkIsMulti(name + temp) {
//                    print(name + temp)
                    queue.insert((name + temp, inputIndex + 1), at : 0)
                }
            
            
                if inputIndex + 1 < arr.count{
                    temp = arr[inputIndex] + arr[inputIndex + 1]
                    
                    if Int(temp)! <= 50{
                        
                        if !checkIsMulti(name + " " + temp) {
                            queue.insert((name + " " + temp, inputIndex + 2 ), at : 0)
                        }
                    }
                    
                }
            
            }
               
        }
        
    }
    
    
}

//main()

var arr2 : [Int] = []
var totalLen2 : Int = 0

func main2(){
    
    let input = readLine()!
    arr2 = Array(input).map({Int(String($0))!})
    totalLen2 = arr2.count
    
    if arr2.count == 1 {
        print("1")
        return
    }
    
    DFS()
    
}


func DFS(){
    
    
    
}
