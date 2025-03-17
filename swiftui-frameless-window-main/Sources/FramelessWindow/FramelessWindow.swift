import SwiftUI
import WindowReference

/**
 A SwiftUI scene that creates a bare single window without the included default items.

 A frameless window does not include a title bar and neither the minimize nor the zoom
 default window buttons. Additionally it is excluded from the applications window menu.
 */
public struct FramelessWindow<Content: View>: Scene {
	public typealias WindowInitializer = (NSWindow) -> Void

	let titleKey: LocalizedStringKey
	let id: String
	let content: () -> Content
	let windowInitializer: WindowInitializer

	/// A `Window` scene with a content that ignores any safe area and puts a window reference
	/// into the environment.
	public var body: some Scene {
		Window(self.titleKey, id: self.id) {
			WindowReference(withId: self.id, andWindowInitializer: self.modify(window:)) {
				self.content()
			}.ignoresSafeArea()
		}.windowStyle(.hiddenTitleBar)
	}

	/**
	 Initialize a new FramelessWindow Scene.

	 - Parameters:
	 - id: A unique string identifier that you can use to open the window.
	 - title: A localized string key to use for the window’s title in system menus and in the
	 window’s title bar. Provide a title that describes the purpose of the window. As
	 a frameless window does not have a title bar and does not appear in the application
	 window menu, this value has no effect.
	 - windowInitializer: Closure to modify the containing NSWindow of the scene.
	 - content: The view content to display in the window.
	 */
	public init(_ title: LocalizedStringKey, id: String, windowInitializer: WindowInitializer? = nil, @ViewBuilder content: @escaping () -> Content) {
		self.titleKey = title
		self.id = id
		self.content = content
		self.windowInitializer = windowInitializer ?? {window in}
	}

	/**
	 Initialize a new FramelessWindow Scene without a title, which defaults to `"Launcher"`.

	 - Parameters:
	 - id: A unique string identifier that you can use to open the window.
	 - windowInitializer: Closure to modify the containing NSWindow of the scene.
	 - content: The view content to display in the window.
	 */
	public init(id: String, windowInitializer: WindowInitializer? = nil, @ViewBuilder content: @escaping () -> Content) {
		self.init("Launcher", id: id, windowInitializer: windowInitializer, content: content)
	}

	/**
	 Initialize a new FramelessWindow Scene without a title, which defaults to `"Launcher"` and id.
	 id defaults to some random UUID.

	 - Parameters:
	 - windowInitializer: Closure to modify the containing NSWindow of the scene.
	 - content: The view content to display in the window.
	 */
	public init(windowInitializer: WindowInitializer? = nil, @ViewBuilder content: @escaping () -> Content) {
		self.init(id: UUID().uuidString, windowInitializer: windowInitializer, content: content)
	}

	/// Hide the miniaturize and zoom default window buttons and remove the window from the application window menu.
	private func modify(window: NSWindow) {
		window.standardWindowButton(.miniaturizeButton)?.isHidden = true
		window.standardWindowButton(.zoomButton)?.isHidden = true
		window.isExcludedFromWindowsMenu = true
		self.windowInitializer(window)
	}
}
