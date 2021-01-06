import Foundation

//func main(){
//
//    let testCase : Int = Int(readLine()!)!
//
//    for _ in 0..<testCase{
//
//    let n = input()
//
//    var dict : [Int : Int] = [:]
//    var exist : Set<[Int]> = []
//    var checkList : [Bool] = Array(repeating : false , count : n + 1)
//
//    for (index, item) in list.enumerated(){
//        dict[index + 1] = item
//    }
//
//    var answer = 0
//
//    for i in 1...n{
//
//        if !checkList[i]{
//
//        var visited : [Bool] = Array(repeating : false , count : n + 1)
//
//        var next = i
//
//        while visited[next] != true {
//
//            visited[next] = true
//            next = dict[next]!
//
//        }
//
//        if next == i {
//            let offsets = visited.enumerated().filter({$0.element == true}).map({$0.offset}).sorted()
//
//            if !exist.contains(offsets) {
//
//                for index in offsets{
//                    checkList[index] = true
//                }
//                exist.insert(offsets)
//
//                answer += 1
//            }
//        }
//
//        }
//
//    }
//
//    print(answer)
//
//    }
//
//
//}
//
////main()
//var list : [Int] = []
//var visited : [Bool] = []
//var dict : [Int : Int] = [:]
//
//
//
//func dfs(_ index : Int) -> Int{
//
//    if visited[index] {
//        return 1
//    }
//    visited[index] = true
//    let next = dict[index]!
//
//    return dfs(next)
//}
//
//func main2(){
//
//    let testCase : Int = Int(readLine()!)!
//
//    for _ in 0..<testCase{
//
//    let n = input()
//
//    visited = Array(repeating : false , count : n + 1)
//    var answer = 0
//
//        dict = [:]
//    for (index, item) in list.enumerated(){
//        dict[index + 1] = item
//    }
//
//    for i in 0..<n{
//
//        if !visited[i + 1]{
//            answer += dfs(i+1)
//        }
//
//    }
//
//    print(answer)
//
//    }
//
//}

//main2()

var list : [Int] = []
var visited : [Bool] = []

func input() -> Int{

    let total = Int(readLine()!)!

    list = readLine()!.components(separatedBy : " ").map({Int($0)!})

    return total

}

func main3(){
    
    let testCase : Int = Int(readLine()!)!
    
    for _ in 0..<testCase{
    
    let n = input()
    
    visited = Array(repeating : false , count : n + 1)
    var answer = 0
    list.insert(0, at : 0)
    
        func dfs3(_ index : Int) -> Int{
            
            var next = index
            
            while !visited[next] {
                visited[next] = true
                next = list[next]
            }
            
            if next == index{
                return 1
            }
            
            return 0
            
        }
        
        for i in 1...n{
            
            if !visited[i]{
                answer += dfs3(i)
            }
            
        }
        
        print(answer)
    
    
    }
    
}

main3()
