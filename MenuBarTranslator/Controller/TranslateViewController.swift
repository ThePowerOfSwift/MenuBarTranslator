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

	@IBOutlet weak var inputView: InputTranslateView!
	@IBOutlet weak var outputView: TranslateView!

	@IBOutlet weak var inputLanguageButton: LanguageButton!
	@IBOutlet weak var outputLanguageButton: LanguageButton!

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
			if !self.inputView.textView.isEmpty && language.isAutoLanguage {
				Dictionary.shared.detectLanguage(by: self.inputView.textView.string, completion: { (lang) in
					guard let lang = lang else {
						return
					}
					sender.language = Languages.searchLanguage(by: lang)
				})
			}
		}
	}

	var player: AVAudioPlayer?

	override func viewDidLoad() {
		super.viewDidLoad()
		yandexReferenceSetup()
		preferencesButtonSetup()

		inputView.clearButton.action = #selector(clearButtonClicked(_:))

		inputView.pronounceButton.action = #selector(pronounce(_:))
		outputView.pronounceButton.action = #selector(pronounce(_:))

		inputLanguageButton.language = Languages.english
		outputLanguageButton.language = Languages.russian

		inputView.textView.delegate = self

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
		   let event = NSApp.currentEvent {
			NSMenu.popUpContextMenu(menu, with: event, for: sender)
		}
	}

	@IBAction func clearButtonClicked(_ sender: NSButton) {
		inputView.textView.isEmpty = true
		outputView.textView.isEmpty = true

		updatePronounceLanguages()
	}

	@IBAction func pinButtonClicked(_ sender: NSButton) {
		let delegate = NSApplication.shared.delegate as! AppDelegate
		delegate.popover.behavior = sender.state == .on ? .semitransient : .transient
		(sender.image, sender.alternateImage) = (sender.alternateImage, sender.image)
	}

	@IBAction func languageButtonClicked(_ sender: NSButton) {
		if (inputLanguageButton.state == outputLanguageButton.state && sender.state == .on) {
			if (sender == inputLanguageButton) {
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
	}

	@IBAction func pronounce(_ sender: PronounceButton) {
		guard let superview = sender.superview as? TranslateView,
			  let textView = superview.textView,
			  let language = sender.language,
			  !language.isAutoLanguage && !textView.isEmpty else {
			return
		}

		Dictionary.shared.pronounce(text: textView.string, for: language) { (url) in
			guard let data = try? Data(contentsOf: url),
				  let action = try? AVAudioPlayer(data: data) else {
				return
			}
			self.player = action
			self.player?.play()
		}
	}

	@IBAction func swap(_ sender: NSButton) {
		if isTranslated {
			(inputView.textView.string, outputView.textView.string) = (outputView.textView.string, inputView.textView.string)
		}

		if let language = inputLanguageButton.language,  !language.isAutoLanguage {
			(inputLanguageButton.language, outputLanguageButton.language) = (outputLanguageButton.language, inputLanguageButton.language)
		}
		updatePronounceLanguages()
	}

}


