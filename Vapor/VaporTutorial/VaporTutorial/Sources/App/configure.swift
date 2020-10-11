import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    
    app.directory.publicDirectory = "/Volumes/T7/Xcode_TestProj/Vapor/VaporTutorial/VaporTutorial/Public"
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //register Leaf - leaf 등록
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    //경로 설정을 바꿔줘야 한다.
    app.leaf.configuration.rootDirectory = "/Volumes/T7/Xcode_TestProj/Vapor/VaporTutorial/VaporTutorial/Sources/Resources/Views"
    
    // register routes
    try routes(app)
}
