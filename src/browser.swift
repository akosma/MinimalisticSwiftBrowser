#!/usr/bin/env xcrun swift

import WebKit

class WindowDelegate: NSObject, NSWindowDelegate {
    func windowWillClose(notification: NSNotification) {
        NSApplication.sharedApplication().terminate(0)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow

    init(window: NSWindow) {
        self.window = window
    }

    func applicationDidFinishLaunching(notification: NSNotification) {
        if let mainView = self.window.contentView,
            let url = NSURL(string: "https://developer.apple.com/swift/") {
                let webView = WebView(frame: mainView.bounds)
                mainView.addSubview(webView)
                let request = NSURLRequest(URL: url)
                webView.mainFrame.loadRequest(request)
            }
    }
}

let rect = NSMakeRect(0, 0, 800, 600)
let style = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
let window = NSWindow(contentRect: rect,
                        styleMask: style,
                        backing: NSBackingStoreType.Buffered,
                        `defer`: false)
window.center()
window.title = "Minimal Swift WebKit Browser"
window.makeKeyAndOrderFront(nil)

let windowDelegate = WindowDelegate()
window.delegate = windowDelegate

let appDelegate = AppDelegate(window: window)

let app = NSApplication.sharedApplication()
app.setActivationPolicy(.Regular)
app.delegate = appDelegate
app.activateIgnoringOtherApps(true)
app.run()

