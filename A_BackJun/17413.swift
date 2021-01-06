import Foundation


func main(){
    let input = readLine()!.map({String($0)})
    
    var flagTag : Bool = false
    var insertWord = ""
    var answer : String = ""
    
    for item in input{
    
        if flagTag {
            
            insertWord.append(item)
            
            if item == ">"{
                flagTag = false
                answer.append(insertWord)
                insertWord = ""
            }
            
        }
        else{
            
            if item == "<" {
                let insert = insertWord.reversed()
                answer.append(contentsOf: insert)
                insertWord = ""
                insertWord.append(item)
                flagTag = true
                continue
            }
            
            if item == " "{
                let insert = insertWord.reversed() + " "
                answer.append(contentsOf: insert)
                insertWord = ""
                continue
            }
            
                insertWord.append(item)
            
            
        }
        
    }
    
    if insertWord != "" {
        let insert = insertWord.reversed() + " "
        answer.append(insert)
        insertWord = ""
    }
    
    print(answer)
    
}

main()
