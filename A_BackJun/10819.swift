import Foundation

var inputs : [Int] = [20 ,1 ,15 ,8 ,4 ,10,4,6]
var maxValue : Int = 0

func main(){
    
    let N = Int(readLine()!)!
    inputs = readLine()!.components(separatedBy: " ").map({Int($0)!})
    
    permutation(current: 0, maxCnt: N, inputs: inputs, result: [])
    
    print(maxValue)
}

func permutation(current : Int , maxCnt : Int, inputs : [Int], result : [Int]){
    
    var tempResult = result
    var tempInputs = inputs
    
    if current == maxCnt {
        
        var total : Int = 0
        
        for index in 0...result.count - 2{
            total += abs(result[index] - result[index + 1])
        }
        
//        print(result , terminator : " ")
//        print(total)
        
        maxValue = max(total, maxValue)
        
    }
    else{
        
        for (index, element) in tempInputs.enumerated(){
            
            tempInputs.remove(at: index)
            tempResult.append(element)
            permutation(current: current + 1, maxCnt: maxCnt, inputs: tempInputs, result: tempResult)
            tempInputs.insert(element, at: index)
            tempResult.removeLast()
            
            
        }
        
    }
    
}

main()

func permutate(_ cur : Int){
    
    if cur == inputs.count {
        
        print(inputs)
    }
    else{
        
        for i in cur..<inputs.count{
            
            inputs.swapAt(i, cur)
            permutate(cur + 1)
            inputs.swapAt(i, cur)
        }
        
    }
    
}
