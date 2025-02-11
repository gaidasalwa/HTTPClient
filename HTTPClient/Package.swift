
// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "HTTPClient",
    products: [
        .library(
            name: "HTTPClient",
            targets: ["HTTPClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMinor(from: "5.10.0"))
    ],
     
    targets: [
        .target(
            name: "HTTPClient",
            dependencies: ["Alamofire"]
        ),
        .testTarget(
            name: "HTTPClientTests",
            dependencies: ["HTTPClient"]
        ),
    ]
)
