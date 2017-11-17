//
//  TranslateViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.07.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa
import AVFoundation

class TranslateViewController: NSViewController, AVAudioPlayerDelegate {
	@IBOutlet weak var yandexReferenceLabel: NSTextField!
	@IBOutlet weak var preferencesButton: NSButton!

	@IBOutlet var inputTextView: TranslateTextView!

	override func viewDidLoad() {
		super.viewDidLoad()
		yandexReferenceSetup()
		preferencesButtonSetup()

		inputTextView.delegate = self
	}

	override func viewDidAppear() {
		super.viewDidAppear()
		NSApplication.shared.activate(ignoringOtherApps: true)
	}

	@IBAction func preferencesClicked(_ sender: NSButton) {
		if let menu = sender.menu,
			let event = NSApp.currentEvent{
			NSMenu.popUpContextMenu(menu, with: event, for: sender)
		}
	}
	
	@IBAction func clearButtonClicked(_ sender: NSButton) {
		inputTextView.isEmpty = true
	}

	@IBAction func pinButtonClicked(_ sender: NSButton) {
		let delegate = NSApplication.shared.delegate as! AppDelegate
		delegate.popover.behavior = sender.state == .on ? .semitransient: .transient
		(sender.image, sender.alternateImage) = (sender.alternateImage, sender.image)
	}
	@IBAction func languageButtonClicked(_ sender: NSButton) {
		
	}
}


