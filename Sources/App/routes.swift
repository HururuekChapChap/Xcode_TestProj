import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "This is First HururuekChapChpa Home Web"
    }

    app.get("publicDirectory") { req -> String in
        return "\(app.directory.publicDirectory)"
    }
    
    
    app.post("insert") { (req) -> EventLoopFuture<[Todo]> in
        
        if let title = try? req.content.decode(Todo.self){
            
            let save = title.save(on: req.db)
            let temp =  save.and(Todo.query(on: req.db).all()).map { (save, read) -> ([Todo]) in
                return read
            }
            
            return temp
            
        }
        
        return Todo.query(on: req.db).all()
        
    }

}
