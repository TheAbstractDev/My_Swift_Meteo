import PackageDescription

let package = Package(
    name: "My_Swift_Meteo_Server",
    exclude: ["views", "dist", "public"],
    dependencies: [
        .Package(url: "https://github.com/crossroadlabs/Express.git", majorVersion: 0, minor: 3),
        .Package(url: "https://github.com/Danappelxx/SwiftMongoDB", majorVersion: 0, minor: 5)
    ]
)
