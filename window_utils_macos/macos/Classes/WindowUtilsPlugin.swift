import Cocoa
import FlutterMacOS
import Foundation
import WebKit

public class WindowUtilsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "sample/window_util", binaryMessenger: registrar.messenger)
        let instance = WindowUtilsPlugin(channel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)

        NSLog("Registering windows plugin")
    }

    var _channel: FlutterMethodChannel
    init(channel flutterChannel: FlutterMethodChannel) {
        _channel = flutterChannel
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "openWebView":
            createWebWindow()
        case "closeWebView":
            result(closeWindow())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func createWebWindow() {
        print("createWebWindow")
        let _webView = WebView()
        let window = NSWindow()
        window.styleMask = NSWindow.StyleMask(rawValue: 0xF)
        window.backingType = .buffered
        window.title = "window_title"
        window.contentViewController = _webView
        window.setFrameOrigin(NSPoint(x: 100, y: 100))
        window.setContentSize(NSSize(width: 800, height: 600))
        let windowController = NSWindowController()
        windowController.contentViewController = window.contentViewController
        windowController.window = window
        windowController.showWindow(self)
    }

    func closeWindow() -> Bool {
        let window = NSApp.windows.first(where: { $0.title == "window_title" })
        window?.close()
        return true
    }
}

class WebView: NSViewController, WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate, NSWindowDelegate {
    var webView: WKWebView!
    var url = "https://www.apple.com"
    var jsHandler: String = ""
    // NSViewController
    override func loadView() {
        print("loadView")
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        // Register as WKUIDelegate
        webView.uiDelegate = self
        // Register as WKNavigationDelegate
        webView.navigationDelegate = self
        view = webView

    }

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        let htmlString = """
        <!DOCTYPE html>
        <html>
        <body>

        <h1>The input element</h1>

        <form action="/action_page.php">
            <label for="fname">First name:</label>
            <input type="text" id="fname" name="fname"><br><br>
            <label for="lname">Last name:</label>
            <input type="text" id="lname" name="lname"><br><br>
        </form>

        </body>
        </html>

        """
        webView.loadHTMLString(htmlString, baseURL: nil)

    }


    // WKScriptMessageHandler
    func userContentController(_: WKUserContentController, didReceive message: WKScriptMessage) {
        print("userContentController")
    }

    // NSWindowDelegate
    func windowWillClose(_: Notification) {
        print("windowWillClose")
    }

    // WKNavigationDelegate
    func webView(_: WKWebView, didReceiveServerRedirectForProvisionalNavigation _: WKNavigation!) {
        print("webview called")
    }

    deinit {
        webView = nil
    }
}
