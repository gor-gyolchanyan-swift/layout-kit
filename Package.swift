// swift-tools-version:5.4

//
// Introductory information can be found in the `README.md` file located at the root of the repository that contains this file.
// Licensing information can be found in the `LICENSE` file located at the root of the repository that contains this file.
//

import PackageDescription

let package = Package(
    name: "LayoutKit",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LayoutKit",
            targets: ["LayoutKit"]
        ),
    ],
    targets: [
        .target(
            name: "LayoutKit"
        )
    ]
)
