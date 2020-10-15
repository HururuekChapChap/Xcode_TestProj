import Vapor
import Leaf
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    
    app.directory.publicDirectory = "/Volumes/T7/Xcode_TestProj/Vapor/VaporTutorial/VaporTutorial/Public"
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    //configure postgresql - 데이터베이스 등록
    //host주소 / postgresql의 owner에 해당하는 부분 / 초기 패스워드 "" / 테이블
    app.databases.use(.postgres(hostname: "localhost", username: "yoontaesoo", password: "", database: "test1"), as: .psql)
    
    //테이블 생성
    app.migrations.add(CreateTestModel())
    //테이블 생성
    app.migrations.add(CreateUserModel())
    
    //register Leaf - leaf 등록
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    //경로 설정을 바꿔줘야 한다.
    app.leaf.configuration.rootDirectory = "/Volumes/T7/Xcode_TestProj/Vapor/VaporTutorial/VaporTutorial/Sources/Resources/Views"
    
    // register routes
    try routes(app)
}
