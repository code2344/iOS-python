// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PythonPad",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "PythonPad",
            targets: ["PythonPad"])
    ],
    dependencies: [
        // Add Python support for Swift
        .package(url: "https://github.com/pvieito/PythonKit.git", branch: "master")
    ],
    targets: [
        .target(
            name: "PythonPad",
            dependencies: ["PythonKit"])
    ]
)
