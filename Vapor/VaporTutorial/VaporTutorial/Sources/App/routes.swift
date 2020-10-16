import Vapor
import Leaf
import Fluent

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
    
    //저장하기
    app.get("testInput"){ req -> EventLoopFuture<user> in
        
        let test = user.init(status: "test")
        return test.save(on: req.db).map { (result) -> user in
            return test
        }
    }
    
    //UUID로 찾기 및 변경
    app.get("find",":id"){ req -> EventLoopFuture<user> in
            
        let id = req.parameters.get("id" , as : UUID.self)
        
        let test = user.find(id, on: req.db)
        let temp = test.unwrap(or: Abort(.notFound)).map({ (result) -> user in
            
            result.status = "update"
            result.save(on: req.db)
            
            return result
        })
        
        return temp
    }
    
    //UUID 없이 찾기
    app.get("findItem"){ req -> EventLoopFuture<user> in
            
        let test = user.query(on: req.db).filter(\.$status == "test").first().unwrap(or: Abort(.notFound)).map { (result) -> user in
            return result
        }
        
        return test
    }
    
    //삭제
    app.get("deleteItem"){ req -> String in
        
    let test = user.query(on: req.db).filter(\.$status == "test").first().unwrap(or: Abort(.notFound)).map { (result) -> EventLoopFuture<Void> in
            return result.delete(on: req.db)
        }
        
        print(test)
        
        return "query finish"
    }
    
    app.get("getMutiple"){ req -> EventLoopFuture<[user]> in
            
        return user.query(on: req.db).filter(\.$status == "test").all()
    }
    

}
