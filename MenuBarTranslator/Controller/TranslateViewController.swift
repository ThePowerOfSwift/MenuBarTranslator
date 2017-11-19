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
	@IBOutlet var outputTextView: TranslateTextView!

	@IBOutlet weak var inputLanguageButton: LanguageButton!
	@IBOutlet weak var outputLanguageButton: LanguageButton!

	@IBOutlet weak var inputPronounceButton: PronounceButton!
	@IBOutlet weak var outputPronounceButton: PronounceButton!

	@IBOutlet weak var mainTranslateView: NSView!
	
	@IBOutlet weak var languagePicker: LanguagePickerView!


	var isTranslated = false
	var languages = Languages.languages
	var recentLanguages = Languages.standart
	var languageSender: LanguageButton? {
		didSet {
			guard let sender = languageSender,
				let language = sender.language else {
				return
			}
			if !self.inputTextView.isEmpty && language == Languages.auto {
				print("detection")
				Dictionary.shared.detectLanguage(by: self.inputTextView.string, completion: { (lang) in
					guard let lang = lang else {
						return
					}
					sender.language = Languages.searchLanguage(by: lang)
				})
			}
			self.updatePronounceLanguages()
		}
	}

	var player : AVAudioPlayer?

	override func viewDidLoad() {
		super.viewDidLoad()
		yandexReferenceSetup()
		preferencesButtonSetup()

		inputLanguageButton.language = Languages.english
		outputLanguageButton.language = Languages.russian

		inputTextView.delegate = self

		languagePicker.allLanguages.dataSource = self
		languagePicker.allLanguages.delegate = self

		languagePicker.searchTextField.delegate = self

		languagePicker.recentLanguages.dataSource = self
		languagePicker.recentLanguages.delegate = self

		languagePicker.isHidden = true

		updatePronounceLanguages()
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
		
		if let button = sender as? LanguageButton {
			languageSender = button
		}

		updatePronounceLanguages()
	}

	@IBAction func pronounce(_ sender: PronounceButton) {
		guard let superview = sender.superview as? TranslateView,
			let textView = superview.textView,
			let language = sender.language,
			language != Languages.auto && !textView.isEmpty else {
				sender.isEnabled = false
				return
		}
		let requestor = RequestProcessor(request: Yandex.pronounce(text: textView.string, language: language).request)

		requestor.getData { (url, _, _) in
			guard let url = url else {
				return
			}
			guard let data = try? Data(contentsOf: url),
				let action = try? AVAudioPlayer(data: data) else {return}
			self.player = action
			self.player?.play()
		}
	}
	
	@IBAction func swap(_ sender: NSButton) {
		if isTranslated {
			(inputTextView.string, outputTextView.string) = (outputTextView.string, inputTextView.string)
		}

		if inputLanguageButton.language != Languages.auto {
			(inputLanguageButton.language, outputLanguageButton.language) = (outputLanguageButton.language, inputLanguageButton.language)
		}
	}
	
}


