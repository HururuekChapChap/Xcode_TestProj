
import Foundation

print("Insert Inputs")
var x : [String : Int] = [:]
var y : [String : Int] = [:]

stride(from: 0, to: 3, by: +1).forEach { (number) in
    
    let input = readLine()?.components(separatedBy: " ")
    
    if let exist = x[input![0]]{
        x[input![0]] = exist + 1
    }
    else{
        x[input![0]] = 1
    }
    
    if let exist = y[input![1]]{
        y[input![1]] = exist + 1
    }
    else{
        y[input![1]] = 1
    }
    
}

for item in x {
    if item.value % 2 != 0 {
        print(item.key , terminator:" ")
    }
}

for item in y {
    if item.value % 2 != 0 {
        print(item.key , terminator:"")
    }
}
