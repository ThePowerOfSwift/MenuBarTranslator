//
//  TranslateViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.07.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa


class TranslateViewController: NSViewController {

	// MARK: variables
	@IBOutlet weak var inputTextField: ResizableTextField!
	@IBOutlet weak var outputTextField: ResizableTextField!

	@IBOutlet weak var swapButton: NSButton!
	@IBOutlet weak var fromLangSegControl: LanguagesSegmentControl!
	@IBOutlet weak var toLangSegControl: LanguagesSegmentControl!

	@IBOutlet weak var scrollView: NSScrollView!
	@IBOutlet weak var clipView: NSClipView!

	let langsPopover = NSPopover()
	let autoCompletePopover = NSPopover()
	static var isOutputTextFieldAlreadyHidden: Bool = true

	override func viewDidLoad() {
		super.viewDidLoad()
		self.swapButton.bezelStyle = .texturedRounded
		inputTextField.delegate = self
		outputTextField.isHidden = true
		inputTextField.allowsEditingTextAttributes = true

		fromLangSegControl.queue = QueueInt(withInterval: 0..<fromLangSegControl.segmentCount - 1)
		toLangSegControl.queue = QueueInt(withInterval: 0..<toLangSegControl.segmentCount)

		fromLangSegControl.values = Languages.StandartLanguages
		toLangSegControl.values = Languages.StandartLanguages
		langsPopover.behavior = NSPopoverBehavior.transient
		langsPopover.animates = true
		langsPopover.contentViewController = AllLanguagesViewController(nibName: "AllLanguagesViewController", bundle: nil)
		langsPopover.contentViewController?.view.acceptsTouchEvents = true

		autoCompletePopover.behavior  = .transient
		autoCompletePopover.animates = true
		autoCompletePopover.contentViewController = AutocompleteViewController(nibName: "AutocompleteViewController", bundle: nil)
		let appearance = NSAppearance()
		autoCompletePopover.appearance = appearance

	}

	override func viewDidAppear() {
		super.viewDidAppear()
		NSApplication.shared().activate(ignoringOtherApps: true)
	}

	@IBAction func swapButtonClicked(_ sender: NSButton) {
		guard let fromLanguage = fromLangSegControl[fromLangSegControl.selectedSegment],
			let toLanguage = toLangSegControl[toLangSegControl.selectedSegment] else {
				return
		}
		if let fromLanguageIndex = fromLangSegControl.values.index(of: toLanguage),
			let toLanguageIndex = toLangSegControl.values.index(of: fromLanguage){
			(fromLangSegControl.selectedSegment, toLangSegControl.selectedSegment) = (fromLanguageIndex, toLanguageIndex)
			(inputTextField.stringValue, outputTextField.stringValue) = (outputTextField.stringValue, inputTextField.stringValue)

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
		guard !inputTextField.isEmpty else {
			return
		}
		Dictionary.shared.detectLanguage(byText: inputTextField.stringValue, completion: { lang in
			guard let lang = lang,
				let newLanguage = Languages.shared.searchLanguage(byShortName: lang) else {
					self.fromLangSegControl.detectedLanguage = nil
					return
			}
			self.fromLangSegControl.detectedLanguage = newLanguage
		})
	}
}

// MARK: TextField delegate
extension TranslateViewController:  NSTextFieldDelegate {
	func switchHiddennessOutputTextField () {
		if(inputTextField.isEmpty && !TranslateViewController.isOutputTextFieldAlreadyHidden) {
			TranslateViewController.isOutputTextFieldAlreadyHidden = true
			outputTextField.isHidden = true
			outputTextField.isEmpty = true
		}
		else if TranslateViewController.isOutputTextFieldAlreadyHidden {
			TranslateViewController.isOutputTextFieldAlreadyHidden = false
			outputTextField.isHidden = false
		}
	}

	override func controlTextDidEndEditing(_ obj: Notification) {
		guard !inputTextField.isEmpty else {
			return
		}
		let from = fromLangSegControl[fromLangSegControl.selectedSegment]
		let to = toLangSegControl[toLangSegControl.selectedSegment]!
		Dictionary.shared.translate(inputTextField.stringValue, from: from, to: to, completionHandler: { text in
			guard let text = text else {
				self.outputTextField.stringValue = self.inputTextField.stringValue
				return
			}
			self.outputTextField.stringValue = text
		})
	}

	override func controlTextDidChange(_ obj: Notification) {
		print(inputTextField.attributedStringValue)
		switchHiddennessOutputTextField()
		fromLangSegControl.detectedLanguage = nil
		if inputTextField.isEmpty {
			scrollView.scroll(clipView, to: NSZeroPoint)
		}

		guard fromLangSegControl.currectLanguage == Languages.english &&
			1...10 ~= inputTextField.stringValue.characters.count  && !inputTextField.stringValue.contains(" ")else {
			autoCompletePopover.close()
			return
		}


//		Dictionary.shared.suggest(toWord: inputTextField.stringValue, completion: { suggestedWords in
//			guard let words = suggestedWords else {
//				return
//			}
//			print("words",words)
//		})

		
	}
}
