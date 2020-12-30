import Foundation

var input : [String] = ["2", "1", "1", "2"]

input = readLine()!.components(separatedBy: " ")

//rotate circle
var minValue : Int = Int.max

for start in stride(from: 0, to: 4, by: 1){
    
    var cnt = 0
    var temp = start
    var number : String = ""
    while cnt < 4 {
        
        if temp > 3 {
            temp = 0
        }
        
        number += input[temp]
        cnt += 1
        temp += 1
    }
    
    //most small
    
    minValue = min(Int(number)!, minValue)
    
}

//print(minValue)

//get small numbers

var sets : Set<String> = []
var answer = 0

for element in stride(from: 1111, to: minValue, by: 1){
    
    let makeString = Array(String(element)).map({String($0)})
    
    if !makeString.contains("0") {
        
        var flag = true
        
        var list : [String] = []
        //rotate
        for start in stride(from: 0, to: 4, by: 1){
            
            var cnt = 0
            var temp = start
            var number : String = ""
            while cnt < 4 {
                
                if temp > 3 {
                    temp = 0
                }
                
                number += makeString[temp]
                cnt += 1
                temp += 1
            }
            
            if sets.contains(number) {
                flag = false
            }
            
            list.append(number)
            
        }
        
        if flag {
//            print(makeString)
            answer += 1
        }
        
        for item in list{
            sets.insert(item)
        }
    }
    
}

print(answer + 1)

