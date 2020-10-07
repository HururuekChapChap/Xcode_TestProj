import Fluent
import Vapor

struct Info :Content {
    
    let frameWork : String
    let version : Int
    
}

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("Json_req") { (req) -> [String : String] in
        return ["Hello" : "Vapor", "Name" : "Hururuek_ChapChap"]
    }
    
    app.get("Parameter",":String") { (req) -> String in
        
        let param = req.parameters.get("String") ?? "Empty"
        
        return "you send \(param)"
    }
    
    app.get("hello", "vapor") { (req) -> Info in
        return Info(frameWork: "Vapor", version: 4)
    }
    
    app.post("postRequest") { (req) -> Info in
        
        if let info = try? req.content.decode(Info.self){
            return info
        }
        
        return Info(frameWork: "Empty", version: -1)
    }

    
}
