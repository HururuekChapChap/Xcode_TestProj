import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

//    app.databases.use(.postgres(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//    ), as: .psql)
    
    try app.databases.use(.postgres(url: Environment.databaseURL), as: .psql)
    
    app.migrations.add(CreateTodo())

    if app.environment == .development{
        try app.autoMigrate().wait()
    }
    
    // register routes
    try routes(app)
}

extension Environment {
    
    static var databaseURL: URL {
        
        guard let urlString = Environment.get("DATABASE_URL"), let url = URL(string: urlString) else{
            fatalError("Database url no configured")
        }
        
        return url
    }
}
