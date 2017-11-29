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

	@IBOutlet weak var mainTranslateView: NSView!

	@IBOutlet weak var languagePicker: LanguagePickerView!

	@IBOutlet weak var languageView: LanguageView!
	var isTranslated = false
	var languages = Languages.languages
	var recentLanguages = Languages.standart
	var player: AVAudioPlayer?

	override func viewDidLoad() {
		super.viewDidLoad()
		yandexReferenceSetup()
		preferencesButtonSetup()

		inputView.clearButton.action = #selector(clearButtonClicked(_:))

		inputView.pronounceButton.action = #selector(pronounce(_:))
		outputView.pronounceButton.action = #selector(pronounce(_:))
		languageView.swapButton.action = #selector(swap(_:))
		languageView.inputLanguageButton.action = #selector(languageButtonClicked(_:))
		languageView.outputLanguageButton.action = #selector(languageButtonClicked(_:))
		
		languageView.inputLanguageButton.language = Languages.english
		languageView.outputLanguageButton.language = Languages.russian

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
		if (languageView.isEqualStates && sender.state == .on) {
			if (sender == languageView.inputLanguageButton) {
				languageView.outputLanguageButton.state = .off
			} else {
				languageView.inputLanguageButton.state = .off
			}
		}

		mainTranslateView.isHidden = sender.state == .on
		languagePicker.isHidden = !mainTranslateView.isHidden
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

		if let language = languageView.inputLanguageButton.language,  !language.isAutoLanguage {
			(languageView.inputLanguageButton.language, languageView.outputLanguageButton.language) = (languageView.outputLanguageButton.language, languageView.inputLanguageButton.language)
		}
		updatePronounceLanguages()
	}

}


