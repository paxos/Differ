// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "Differ",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_15),
        .tvOS(.v10),
        .watchOS(.v7)
    ],
    products: [
        .library(name: "Differ", targets: ["Differ"])
    ],
    targets: [
        .target(name: "Differ"),
        .testTarget(name: "DifferTests", dependencies: [
            .target(name: "Differ")
        ])
    ]
)
