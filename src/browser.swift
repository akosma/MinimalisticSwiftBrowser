#!/usr/bin/env xcrun swift

import WebKit

class BrowserWinDelegate: NSObject, NSWindowDelegate {
    func windowWillClose(notification: NSNotification) {
        NSApplication.sharedApplication().terminate(0)
    }
}

class BrowserAppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow

    init(window: NSWindow) {
        self.window = window
    }

    func applicationDidFinishLaunching(notification: NSNotification) {
        let webView = WebView(frame: self.window.contentView.bounds)
        self.window.contentView.addSubview(webView)
        let url = NSURL(string: "https://developer.apple.com/swift/")
        let request = NSURLRequest(URL: url!)
        webView.mainFrame.loadRequest(request)
    }
}

let app = NSApplication.sharedApplication()
app.setActivationPolicy(.Regular)

let rect = NSMakeRect(0, 0, 800, 600)
let style = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
let window = NSWindow(contentRect: rect,
                        styleMask: style,
                        backing: .Buffered,
                        defer: false)
window.center()
window.title = "Minimal Swift WebKit Browser"
window.makeKeyAndOrderFront(nil)

let windowDelegate = BrowserWinDelegate()
window.delegate = windowDelegate

let appDelegate = BrowserAppDelegate(window: window)
app.delegate = appDelegate
app.activateIgnoringOtherApps(true)
app.run()

