// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Persistence",
    platforms: [.iOS("13.0")],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Persistence",
            targets: ["Persistence"])
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.47.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Persistence",
            dependencies: [.product(name: "Realm", package: "realm-swift")])
    ]
)
