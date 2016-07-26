import PackageDescription

let package = Package(
    name: "My_Swift_Meteo_Server",
    dependencies: [
    	.Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0)
    ]
)
