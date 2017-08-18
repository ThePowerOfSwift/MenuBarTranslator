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

	@IBOutlet weak var autocompleteView: NSScrollView!
	@IBOutlet weak var autocompleteTableView: NSTableView!

	let langsPopover = NSPopover()
	static var isOutputTextFieldAlreadyHidden: Bool = true
	var suggestedWords : [String] = ["1" , "2", "3"]
	var autoCompleteKeyDelegate: AutoCompleteKeyDownDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()

		NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
			self.keyDown(with: $0)
			return $0
		}

		autoCompleteKeyDelegate = self
		autocompleteTableView.dataSource = self
		autocompleteTableView.delegate = self
		autocompleteTableView.focusRingType = .none
		autocompleteView.focusRingType = .none


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

	}
	@IBAction func shutDownButtonClicked(_ sender: NSButton) {
		NSApplication.shared().stop(self)
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

	func setTranslatedText() {
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
}
// MARK: autocompleteTableView data source set up
extension TranslateViewController: NSTableViewDataSource {

	func numberOfRows(in tableView: NSTableView) -> Int {
		if suggestedWords.count == 0 {
			self.autocompleteView.isHidden = true
		}
		return suggestedWords.count
	}


	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
		return suggestedWords[row]
	}
}
// MARK: autocompleteTableView delegate set up
extension TranslateViewController: NSTableViewDelegate {
	func tableView(_ tableView: NSTableView,
	               shouldEdit tableColumn: NSTableColumn?,
	               row: Int) -> Bool{
		self.inputTextField.stringValue = suggestedWords[autocompleteTableView.selectedRow]
		autocompleteView.isHidden = true
		self.switchHiddennessOutputTextField()
		self.setTranslatedText()
		return false
	}
}

// MARK: AutoComplete keyDown delegate
extension TranslateViewController: AutoCompleteKeyDownDelegate {
	func upArrowDidPressed() {
		self.updateAutoCompleteTableView()
	}

	func downArrowDidPressed() {
		self.updateAutoCompleteTableView()
	}

	func rightArrowDidPressed() {
		autocompleteView.isHidden = true
		self.switchHiddennessOutputTextField()
		self.setTranslatedText()
	}

	func leftArrowDidPressed() {
		autocompleteView.isHidden = true
		self.switchHiddennessOutputTextField()
		self.setTranslatedText()
	}

	func escDidPressed() {
		autocompleteView.isHidden = true
		self.switchHiddennessOutputTextField()
		self.setTranslatedText()
	}

	func deleteDidPressed() {
		autocompleteView.isHidden = true
		self.switchHiddennessOutputTextField()
		self.setTranslatedText()
	}

	override func keyDown(with event: NSEvent) {
		switch Int(event.keyCode) {
		case Key.upArrow.rawValue:
			autoCompleteKeyDelegate?.upArrowDidPressed()
		case Key.downArrow.rawValue:
			autoCompleteKeyDelegate?.downArrowDidPressed()
		case Key.rightArrow.rawValue:
			autoCompleteKeyDelegate?.rightArrowDidPressed()
		case Key.leftArrow.rawValue:
			autoCompleteKeyDelegate?.leftArrowDidPressed()
		case Key.esc.rawValue:
			autoCompleteKeyDelegate?.escDidPressed()
		case Key.delete.rawValue:
			autoCompleteKeyDelegate?.deleteDidPressed()
		default:
			break
		}
	}

	func updateAutoCompleteTableView() {
		// MARK: Autocomplete set up
		guard fromLangSegControl.currectLanguage == Languages.english &&
			1...10 ~= inputTextField.stringValue.characters.count  && !inputTextField.stringValue.contains(" ")else {
				return
		}

		Dictionary.shared.suggest(toWord: inputTextField.stringValue, completion: { suggestedWords in
			guard let words = suggestedWords else {
				return
			}
			self.autocompleteView.isHidden = false
			self.suggestedWords = words
			self.autocompleteTableView.reloadData()
			if self.autocompleteTableView.acceptsFirstResponder {
				self.view.window?.makeFirstResponder(self.autocompleteTableView)
			}
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

		fromLangSegControl.detectedLanguage = nil
		if inputTextField.isEmpty {
			scrollView.scroll(clipView, to: NSZeroPoint)
		}
	}

	override func controlTextDidChange(_ obj: Notification) {
		switchHiddennessOutputTextField()
// MARK: Setting translated text to output
		self.setTranslatedText()
	}
}
