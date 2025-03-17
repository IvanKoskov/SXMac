// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "swiftui-frameless-window",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "FramelessWindow",
            targets: ["FramelessWindow"])
    ],
	dependencies: [
		.package(url: "https://github.com/astzweig/swiftui-window-reference", from: "1.0.0")
	],
    targets: [
        .target(
			name: "FramelessWindow",
			dependencies: [
				.product(name: "WindowReference", package: "swiftui-window-reference")
			]
		),
		.executableTarget(
			name: "TestApp",
			dependencies: ["FramelessWindow"]
		)
    ]
)
