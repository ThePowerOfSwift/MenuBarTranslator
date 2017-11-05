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
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.highlightMode = true
        statusItem.alternateImage = NSImage(named: NSImage.Name(rawValue: "translate-inversed"))
        
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name(rawValue: "translate"))
            button.action = #selector(togglePopover(_:))
        }
        
        popover.animates = true
        popover.contentViewController = TranslateViewController(nibName: NSNib.Name(rawValue: "TranslateViewController"), bundle: nil)
        popover.behavior = NSPopover.Behavior.transient
        popover.appearance = NSAppearance(named: NSAppearance.Name.vibrantLight)
//		Dictionary.shared.suggest(toWord: "h", completion: { words in
//			print(words)
//		})
    }
    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func showPopover(_ sender: AnyObject?) {
        popover.show(relativeTo: sender!.bounds, of: sender! as! NSView, preferredEdge: .maxY)
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
    
	@objc func togglePopover(_ sender: AnyObject) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}

