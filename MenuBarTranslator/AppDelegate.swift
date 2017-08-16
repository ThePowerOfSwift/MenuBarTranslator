//
//  AppDelegate.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.07.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.highlightMode = true
        statusItem.alternateImage = NSImage(named: "translate-inversed")
        
        if let button = statusItem.button {
            button.image = NSImage(named: "translate")
            button.action = #selector(togglePopover(_:))
        }
        
        popover.animates = true
        popover.contentViewController = TranslateViewController(nibName: "TranslateViewController", bundle: nil)
        popover.behavior = NSPopoverBehavior.transient
        popover.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
		TranslateClient.shared.suggested(toWord: "ca", completion: { suggestedWords in
			guard let words = suggestedWords else {
				return
			}
			print("words",words)
		})
    }
    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func showPopover(_ sender: AnyObject?) {
        popover.show(relativeTo: sender!.bounds, of: sender! as! NSView, preferredEdge: .maxY)
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    func togglePopover(_ sender: AnyObject) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}

