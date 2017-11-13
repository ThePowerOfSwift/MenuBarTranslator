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

	// MARK: variables
	@IBOutlet var inputTextView: NSTextView!
	@IBOutlet var outputTextView: NSTextView!

	@IBOutlet weak var outputTranslateView: TranslateView!
	@IBOutlet weak var inputTranslateView: TranslateView!
	
	@IBOutlet weak var pronounceInputButton: NSButton!
	@IBOutlet weak var pronounceOutputButton: NSButton!
	@IBOutlet weak var swapButton: NSButton!
	@IBOutlet weak var fromLangSegControl: LanguagesSegmentControl!
	@IBOutlet weak var toLangSegControl: LanguagesSegmentControl!
	@IBOutlet weak var preferencesButton: NSButton!

	@IBOutlet weak var inputBoardedScrollView: NSScrollView!
	@IBOutlet weak var outputBoardedScrollView: NSScrollView!
	@IBOutlet weak var yandexAdLabel: NSTextField!

	let langsPopover = NSPopover()
	var player : AVAudioPlayer?
	override func viewDidLoad() {
		super.viewDidLoad()
		let menu = NSMenu()
		menu.addItem(NSMenuItem(title: "Quit MenuBarTranslator", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
		preferencesButton.menu = menu

		outputBoardedScrollView.borderType = .noBorder
		inputBoardedScrollView.borderType = .noBorder

		NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown) {
			self.keyDown(with: $0)
			return $0
		}
		self.swapButton.bezelStyle = .texturedRounded

		textViewsSetup()
		yandexReferenceSetup()

		fromLangSegControl.queue = QueueInt(withInterval: 0..<fromLangSegControl.segmentCount - 1)
		toLangSegControl.queue = QueueInt(withInterval: 0..<toLangSegControl.segmentCount)
		fromLangSegControl.values = Languages.StandartLanguages
		toLangSegControl.values = Languages.StandartLanguages
		langsPopover.behavior = NSPopover.Behavior.transient
		langsPopover.animates = true
		langsPopover.contentViewController = AllLanguagesViewController(nibName: NSNib.Name(rawValue: "AllLanguagesViewController"), bundle: nil)
		langsPopover.contentViewController?.view.acceptsTouchEvents = true

		inputTranslateView.language = Languages.shared.searchLanguage(byShortName: "en")
		outputTranslateView.language = Languages.shared.searchLanguage(byShortName: "ru")
	}
	@IBAction func shutDownButtonClicked(_ sender: NSButton) {
		NSApplication.shared.stop(self)
	}

	override func viewDidAppear() {
		super.viewDidAppear()
		NSApplication.shared.activate(ignoringOtherApps: true)
	}

	@IBAction func swapButtonClicked(_ sender: NSButton) {
		guard let fromLanguage = fromLangSegControl[fromLangSegControl.selectedSegment],
			let toLanguage = toLangSegControl[toLangSegControl.selectedSegment] else {
				return
		}

		if inputTextView.string.count == 0 {
			outputTextView.string = inputTextView.string
		}

		if let fromLanguageIndex = fromLangSegControl.values.index(of: toLanguage),
			let toLanguageIndex = toLangSegControl.values.index(of: fromLanguage){
			(fromLangSegControl.selectedSegment, toLangSegControl.selectedSegment) = (fromLanguageIndex, toLanguageIndex)
			(inputTextView.string, outputTextView.string) = (outputTextView.string, inputTextView.string)

		} else if toLangSegControl.values.index(of: fromLanguage) == nil,
			let fromLanguageIndex = fromLangSegControl.values.index(of: toLanguage),
			let newSelectedSegment = toLangSegControl.queue.frontToTheEnd() {
			toLangSegControl.selectedSegment = newSelectedSegment
			toLangSegControl[newSelectedSegment] = fromLangSegControl[fromLangSegControl.selectedSegment]
			fromLangSegControl.selectedSegment = fromLanguageIndex
		} else if fromLangSegControl.values.index(of: toLanguage) == nil,
			let toLanguageIndex = toLangSegControl.values.index(of: fromLanguage),
			let newSelectedSegment = fromLangSegControl.queue.frontToTheEnd() {
			fromLangSegControl.selectedSegment = toLanguageIndex
			fromLangSegControl[newSelectedSegment] = toLangSegControl[toLangSegControl.selectedSegment]
			toLangSegControl.selectedSegment = toLanguageIndex
		}
	}

	@IBAction func allToLanguagesButtonClicked(_ sender: NSButton) {
		guard let controller = langsPopover.contentViewController as? AllLanguagesViewController else {
			return
		}
		controller.languageSegmentControl = toLangSegControl
		langsPopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
	}

	@IBAction func allFromLanguagesButtonClicked(_ sender: NSButton) {
		guard let controller = langsPopover.contentViewController as? AllLanguagesViewController else {
			return
		}
		controller.languageSegmentControl = fromLangSegControl
		langsPopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
	}

	@IBAction func fromSegmentControlButton(_ sender: LanguagesSegmentControl) {
		guard !inputTextView.isEmpty else {
			return
		}
		Dictionary.shared.detectLanguage(byText: inputTextView.string, completion: { lang in
			guard let lang = lang,
				let newLanguage = Languages.shared.searchLanguage(byShortName: lang) else {
					self.fromLangSegControl.detectedLanguage = nil
					return
			}
			self.inputTranslateView.language = newLanguage
			self.fromLangSegControl.detectedLanguage = newLanguage
		})
	}

	func translateText() {
		guard !inputTextView.isEmpty else {
			return
		}
		let from = fromLangSegControl[fromLangSegControl.selectedSegment]
		let to = toLangSegControl[toLangSegControl.selectedSegment]!
		Dictionary.shared.translate(inputTextView.string, from: from, to: to, completionHandler: { text in
			guard let text = text else {
				self.outputTextView.string = self.inputTextView.string
				return
			}
			self.outputTextView.string = text
		})
	}
	@IBAction func preferencesButtonClicked(_ sender: NSButton) {
		if let menu = sender.menu,
			let event = NSApp.currentEvent{
			NSMenu.popUpContextMenu(menu, with: event, for: sender)
		}
	}

	@IBAction func pronounceTextButtonClicked(_ sender: NSButton) {
		guard let superview = sender.superview as? TranslateView,
			let textView = superview.textView,
			let language = superview.language,
			language.isPronunciationAvailable else {
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

}


