import Foundation

var list : [Int] = []

func input(){
    
    let N = Int(readLine()!)!
    for _ in 0..<N{
        let num = Int(readLine()!)!
        minSort(num)
    }
    
}

func minSort2(_ item : Int){
    
    if list.isEmpty {list.append(item); return}
    
    var start = 0
    var end = list.count - 1
    
    while start <= end {
        
        let mid = (start + end) / 2
        
        if item < list[mid] {
            start = mid + 1
        }
        else{
            end = mid - 1
        }
        
    }
    
    list.insert(item , at : start)
    
}

func minSort(_ x : Int ) {
    if list.isEmpty {
        list.append(x)
    }else {
        var left = -1, right = list.count
        while left+1 < right {
            let pivot = (right+left)/2
            if list[pivot] >= x {
                left = pivot
            }else {
                right = pivot
            }
        }
        list.insert(x, at: right)
    }
}

func main(){
    
    input()
    
    var answer : Int = 0
    
    while !list.isEmpty{
        
        if list.count <= 1 {
            //마지막 하나
            list.removeLast()
            break
        }
        else{
            let number1 = list.removeLast()
            let number2 = list.removeLast()
            answer += number1 + number2
            minSort(number1 + number2)

        }
        
    }
    
    print(answer)
 
}

main()
