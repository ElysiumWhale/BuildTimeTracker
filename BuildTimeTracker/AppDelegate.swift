import Cocoa
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var menuConfiguration: MenuConfiguration!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        menuConfiguration = MenuConfiguration()
        menuConfiguration.configurePopoverView(MainView())
        menuConfiguration.configureButton(with: #selector(togglePopover))
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        guard let button = menuConfiguration.statusItem.button else {
            return
        }

        if popover.isShown {
            popover.performClose(sender)
        } else {
            popover.show(relativeTo: button.bounds,
                         of: button,
                         preferredEdge: NSRectEdge.minY)
            popover.contentViewController?.view.window?.becomeKey()
        }
    }
}

private extension AppDelegate {
    var popover: NSPopover {
        menuConfiguration.popover
    }
}

private struct MenuConfiguration {
    let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    let popover: NSPopover = NSPopover()

    func configureButton(with action: Selector) {
        if let button = statusItem.button {
             button.image = NSImage(systemSymbolName: "chart.bar.fill",
                                    accessibilityDescription: nil)
             button.action = action
        }
    }

    func configurePopoverView<Content: View>(_ view: Content) {
        popover.contentSize = NSSize(width: 500, height: 500)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: view)
    }
}
