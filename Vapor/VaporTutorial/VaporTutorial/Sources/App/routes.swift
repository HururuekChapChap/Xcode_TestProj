import Vapor
import Leaf

func routes(_ app: Application) throws {
    
    app.get { req -> EventLoopFuture<View> in
        
        print("publicDirectory : ", app.directory.publicDirectory)
        
            let name : String = "ChapChap"
        
           return req.view.render("home", ["name": name])
       }

    app.get("hello") { req -> String in
        
        print("directory : ",app.leaf.configuration.rootDirectory)
        return "Hello, world!"
    }
    
    app.get("cupcake") { (req) -> EventLoopFuture<View> in
    
     
               let context = Context(
                name : "ChapChap",
                items: [
                CupCake(id: 1, name: "Vanila", description: "Good", price: 3),
                CupCake(id: 2, name: "Cocolate", description: "Not Bad", price: 1),
                CupCake(id: 3, name: "Cheez", description: "Good", price: 5)
               ]
                
               )
        
        return req.view.render("cupcake", context)
        
    }
    
    app.post("add") { (req) -> String in
        
        if let cupcake = try? req.content.decode(CupCake.self){
            return "\(cupcake)"
        }
        
        return "Error"
    }
    
    app.post("test"){ req -> EventLoopFuture<TestModel> in
        
        let exist = try req.content.decode(TestModel.self)
            
    
        return exist.create(on: req.db).map { (result) -> TestModel in
            return exist
        }
        
        
    }
    
    app.get("testAll"){ req -> EventLoopFuture<[TestModel]> in
        return TestModel.query(on: req.db).all()
    }
    

}
