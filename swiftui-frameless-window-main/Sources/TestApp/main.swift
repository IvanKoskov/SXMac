import SwiftUI
import FramelessWindow

struct TestApp: App {
	var body: some Scene {
		FramelessWindow("Single Window", id: "single-window", windowInitializer: self.modify(window:)) {
			VStack {
				Image(systemName: "globe").font(.title).foregroundStyle(.blue)
				Text("Hello, world!")
			}
		}
	}

	func modify(window: NSWindow) {
		print("Modify window of TestApp was called successfully.")
	}
}

DispatchQueue.main.async {
	let app = NSApplication.shared
	app.setActivationPolicy(.regular)
	app.activate(ignoringOtherApps: true)
}

TestApp.main()
