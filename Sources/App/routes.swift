import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "This is First HururuekChapChpa Home Web"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

}
