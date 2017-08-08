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
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
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
        
//        TranslateClient.shared.languages(completion: { langsArray in
//            guard let langs = langsArray else {
//                return
//            }
//            print(langs)
//        })
//        print(TranslateClient.langsMap)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
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

