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

	@IBOutlet weak var inputLanguageButton: NSButton!
	@IBOutlet weak var outputLanguageButton: NSButton!

	@IBOutlet weak var mainTranslateView: NSView!
	
	@IBOutlet weak var languagePicker: LanguagePickerView!

	let languages = Languages.languages

	override func viewDidLoad() {
		super.viewDidLoad()
		yandexReferenceSetup()
		preferencesButtonSetup()

		inputTextView.delegate = self

		
//		languagePicker.allLanguages.delegate = self
		languagePicker.allLanguages.dataSource = self

		languagePicker.isHidden = true
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
		if(inputLanguageButton.state == outputLanguageButton.state && sender.state == .on) {
			if(sender == inputLanguageButton) {
				outputLanguageButton.state = .off
			} else {
				inputLanguageButton.state = .off
			}
		}
		
		mainTranslateView.isHidden = sender.state == .on
		languagePicker.isHidden = !mainTranslateView.isHidden
	}

	
}


