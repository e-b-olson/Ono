// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Ono",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .watchOS(.v4),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "Ono",
            targets: ["Ono"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Ono",
            dependencies: []),
        .testTarget(
            name: "OnoTests",
            dependencies: ["Ono"],
            resources: [
                .copy("Resources/atom.xml"),
                .copy("Resources/ocf.xml"),
                .copy("Resources/vmap.xml"),
                .copy("Resources/web.html"),
                .copy("Resources/xml.xml"),
            ]),
    ]
)
