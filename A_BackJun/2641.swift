import Foundation

var original : [String] = ["1", "4", "1", "1", "4", "3" ,"3" ,"3" ,"2" ,"2"]
var inputs : [[String]] = [

    ["3" ,"2" ,"2", "1", "4" ,"1" ,"1", "4", "3" ,"3"],
    ["1", "4", "4", "3", "3", "3", "2", "1", "1" ,"2"],
    ["4", "4" ,"1", "1", "1", "2", "3", "3", "2", "3"]

]

inputs = []

let N = Int(readLine()!)!
original = readLine()!.components(separatedBy: " ").map({String($0)})
let n = Int(readLine()!)!
for _ in 0..<n{
    let input = readLine()!.components(separatedBy: " ").map({String($0)})
    inputs.append(input)
}

func main() {
        typealias tuple = (x : Int, y : Int)
        var originSet : Set<String> = []
        var originArray : [tuple] = []
        var x = 0
        var y = 0

        for element in original{
            
            switch element {
            case "1":
                x += 1
            case "2":
                y -= 1
            case "3":
                x -= 1
            case "4":
                y += 1
            default:
                print("Error")
            }
            
            if !originSet.contains(where: {$0 == "\(x)\(y)"}){
                originArray.append(tuple(x: x, y: y))
                originSet.insert("\(x)\(y)")
            }

        }

        //print(originSet)

        var answer : [[String]] = []

        //check is same
        for elements in inputs{
            
            for cordi in originArray{
                
                var item_x = cordi.x
                var item_y = cordi.y
                var cnt = 0
                var temp_set = originSet
                
                    for item in elements{
                        
                        switch item {
                        case "1":
                            item_x += 1
                        case "2":
                            item_y -= 1
                        case "3":
                            item_x -= 1
                        case "4":
                            item_y += 1
                        default:
                            print("Error")
                        }
                    
                        //와리가리 해서 갯수가 동일해질 수 있음
                        if temp_set.contains("\(item_x)\(item_y)"){
                            cnt += 1
                            temp_set.remove("\(item_x)\(item_y)")
                        }
                    
                    }
                
                if cnt == originSet.count {
                    answer.append(elements)
                    break
                }
            }
            
        }

        print(answer.count)

        for element in answer{
            
            for item in element{
                print(item , terminator : " ")
            }
            print()
        }
}

main()
