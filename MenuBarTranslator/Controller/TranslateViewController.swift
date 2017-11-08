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

	@IBOutlet weak var pronounceInputButton: NSButton!
	@IBOutlet weak var pronounceOutputButton: NSButton!
	@IBOutlet weak var swapButton: NSButton!
	@IBOutlet weak var fromLangSegControl: LanguagesSegmentControl!
	@IBOutlet weak var toLangSegControl: LanguagesSegmentControl!

	@IBOutlet weak var yandexAdLabel: NSTextField!

	let langsPopover = NSPopover()

	override func viewDidLoad() {
		super.viewDidLoad()
		yandexReferenceSetup()
		NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown) {
			self.keyDown(with: $0)
			return $0
		}

		self.swapButton.bezelStyle = .texturedRounded

		textViewsSetup()

		fromLangSegControl.queue = QueueInt(withInterval: 0..<fromLangSegControl.segmentCount - 1)
		toLangSegControl.queue = QueueInt(withInterval: 0..<toLangSegControl.segmentCount)
		fromLangSegControl.values = Languages.StandartLanguages
		toLangSegControl.values = Languages.StandartLanguages
		langsPopover.behavior = NSPopover.Behavior.transient
		langsPopover.animates = true
		langsPopover.contentViewController = AllLanguagesViewController(nibName: NSNib.Name(rawValue: "AllLanguagesViewController"), bundle: nil)
		langsPopover.contentViewController?.view.acceptsTouchEvents = true

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

	@IBAction func pronounceText(_ sender: NSButton) {
		guard let superview = sender.superview as? TranslateView,
			let textView = superview.textView else {
			sender.isEnabled = false
			return
		}
		let requestor = RequestProcessor(request: Yandex.pronounce(text: textView.string, lang: "en").request)
		requestor.getData { (url, _, _) in
			guard let url = url else {
				return
			}

			DispatchQueue.main.sync {
				guard let action = try? AVAudioPlayer(contentsOf: url) else {return}
				print(url)
				print(action.data)

				action.play()
			}
		}
	}

}


