import AppKit
import WebKit

final class AppDelegate: NSObject, NSApplicationDelegate, WKNavigationDelegate {
    var window: NSWindow!
    var webView: WKWebView!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let config = WKWebViewConfiguration()
        config.preferences.setValue(true, forKey: "developerExtrasEnabled")

        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1200, height: 800),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "ライブコードエディタ"
        window.minSize = NSSize(width: 700, height: 480)
        window.contentView = webView
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        guard let webDir = Bundle.main.resourceURL?.appendingPathComponent("web"),
              FileManager.default.fileExists(atPath: webDir.appendingPathComponent("index.html").path) else {
            let alert = NSAlert()
            alert.messageText = "web リソースが見つかりません"
            alert.informativeText = "アプリに同梱された index.html を読み込めませんでした。"
            alert.runModal()
            NSApp.terminate(nil)
            return
        }
        let indexURL = webDir.appendingPathComponent("index.html")
        webView.loadFileURL(indexURL, allowingReadAccessTo: webDir)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    // ダウンロードリンク (blob: の a[download] 等) をダウンロードとして扱う
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.shouldPerformDownload {
            decisionHandler(.download)
        } else {
            decisionHandler(.allow)
        }
    }

    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        download.delegate = DownloadDelegate.shared
    }
}

final class DownloadDelegate: NSObject, WKDownloadDelegate {
    static let shared = DownloadDelegate()

    func download(_ download: WKDownload, decideDestinationUsing response: URLResponse, suggestedFilename: String, completionHandler: @escaping (URL?) -> Void) {
        let downloads = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
        var dest = downloads?.appendingPathComponent(suggestedFilename)
        if let d = dest, FileManager.default.fileExists(atPath: d.path) {
            let base = (suggestedFilename as NSString).deletingPathExtension
            let ext = (suggestedFilename as NSString).pathExtension
            var i = 1
            while let c = downloads?.appendingPathComponent(ext.isEmpty ? "\(base)-\(i)" : "\(base)-\(i).\(ext)"),
                  FileManager.default.fileExists(atPath: c.path) {
                i += 1
            }
            dest = downloads?.appendingPathComponent(ext.isEmpty ? "\(base)-\(i)" : "\(base)-\(i).\(ext)")
        }
        completionHandler(dest)
    }
}

let delegate = AppDelegate()
NSApplication.shared.delegate = delegate
NSApplication.shared.run()
