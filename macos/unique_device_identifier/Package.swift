// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "unique_device_identifier",
    platforms: [
        .macOS("10.14"),
    ],
    products: [
        .library(name: "unique-device-identifier", targets: ["unique_device_identifier"])
    ],
    targets: [
        .target(
            name: "unique_device_identifier",
            dependencies: [],
            resources: [
                .process("PrivacyInfo.xcprivacy"),
            ]
        )
    ]
)
