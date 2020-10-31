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
    
    app.get("cupcake2") { req -> EventLoopFuture<View> in
        
        
        struct PassingData : Content {
            let name : String
            let items : [CupCake]
            let users : [user]
        }
        
        let cupcakes = CupCake.query(on: req.db).all()
        let users = user.query(on: req.db).all()
        
        let temp = cupcakes.and(users).flatMap { (cupcake, user) -> EventLoopFuture<View> in
            let data = PassingData(name: "Hururuek", items: cupcake, users: user)
            
            return req.view.render("cupcakeUser", data)
        }
        
        return temp
    }
    
    app.get("cupcake") { (req) -> EventLoopFuture<View> in

        //정렬은 sort로
        let temp = CupCake.query(on: req.db).sort(\.$price).all().flatMap { (results) -> EventLoopFuture<View> in
            let context = Context(name: "test", items: results)
            
            return req.view.render("cupcake", context)
        }
        
//               let context = Context(
//                name : "ChapChap",
//                items: [
//                CupCake(id: 1, name: "Vanila", description: "Good", price: 3),
//                CupCake(id: 2, name: "Cocolate", description: "Not Bad", price: 1),
//                CupCake(id: 3, name: "Cheez", description: "Good", price: 5)
//               ]
//
//               )
        
        return temp
        
    }
    
    app.post("add") { (req) -> EventLoopFuture<Response> in
        
        if let cupcake = try? req.content.decode(CupCake.self){
        
            return cupcake.save(on: req.db).map { (result) -> (Response) in
                return req.redirect(to: "/cupcake")
            }
        }
        
        let temp = req.eventLoop.future(req.redirect(to: "/"))
        
        //go to root page
        return temp
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
    app.get("testInput",":input"){ req -> EventLoopFuture<Response> in
        
        let input = req.parameters.get("input")
        
        let test = user.init(status: input!)
        return test.save(on: req.db).map { (result) -> Response in
            
            let redirect = req.redirect(to: "/")
            
            return redirect
        }
    }
    
    app.get("check",":input"){ req -> EventLoopFuture<String> in
            
        guard let input = req.parameters.get("input") else {throw Abort(.notFound, reason: "nono")}
        
        let check = user.query(on: req.db).filter(\.$status == input).first().flatMap { (result) -> EventLoopFuture<String> in
            
            guard let _ = result else {
                
                let inputData = user.init(status: input)
                let _ = inputData.save(on: req.db)
                
                return req.eventLoop.future("empty")
            }
            
            return req.eventLoop.future("testing")
        }
        
        return check
    }
    
    
    //
    app.get("update",":input"){ req -> EventLoopFuture<user> in
            
        let input = req.parameters.get("input")
        
        return user.query(on: req.db).filter(\.$status == input!).first().unwrap(or: Abort(.notFound)).map { (result) -> (user) in
            
            result.status = "update"
            let _ = result.save(on: req.db)
            return result
        }
        
    }

    //UUID로 찾기 및 변경
    app.get("find",":id"){ req -> EventLoopFuture<user> in
            
        let id = req.parameters.get("id" , as : UUID.self)
        
        let test = user.find(id, on: req.db)
        let temp = test.unwrap(or: Abort(.notFound)).map({ (result) -> user in
            
            result.status = "update"

            let t = result.save(on: req.db)

            let _ = result.save(on: req.db)

            
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
