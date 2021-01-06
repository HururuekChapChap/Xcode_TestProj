import Foundation

func main(){
    
    func checkIsP(_ list : String) -> Bool {
        
        let arr = Array(list).map({String($0)})
        
        var start = 0
        var end = arr.count - 1
        
        while start <= end {
            
            if arr[start] != arr[end]{
                return false
            }
            
            start += 1
            end -= 1
            
        }
        
        return true
        
    }
    
    while true{
    
    let input = readLine()!
    
        if input == "0"{
            return
        }
        
        if checkIsP(input) {
            print("yes")
        }
        else{
            print("no")
        }
        
    }
    
}

main()
