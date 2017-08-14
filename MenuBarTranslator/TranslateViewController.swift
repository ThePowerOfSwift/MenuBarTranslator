//
//  TranslateViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.07.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa


class TranslateViewController: NSViewController {

	@IBOutlet weak var inputTextField: ResizableTextField!
	@IBOutlet weak var outputTextField: ResizableTextField!

	@IBOutlet weak var fromLangSegControl: LanguagesSegmentControl!
	@IBOutlet weak var toLangSegControl: LanguagesSegmentControl!

	let langsPopover = NSPopover()
	static var isOutputTextFieldAlreadyHidden: Bool = true

	override func viewDidLoad() {
		super.viewDidLoad()
		inputTextField.delegate = self
		outputTextField.isHidden = true

		fromLangSegControl.queue = QueueInt(withInterval: 0..<fromLangSegControl.segmentCount - 1)
		toLangSegControl.queue = QueueInt(withInterval: 0..<toLangSegControl.segmentCount)

		fromLangSegControl.values = Languages.StandartLanguages
		toLangSegControl.values = Languages.StandartLanguages

		langsPopover.behavior = NSPopoverBehavior.transient
		langsPopover.animates = true
		langsPopover.contentViewController = AllLanguagesViewController(nibName: "AllLanguagesViewController", bundle: nil)
		langsPopover.contentViewController?.view.acceptsTouchEvents = true
	}

	override func viewDidAppear() {
		super.viewDidAppear()
		NSApplication.shared().activate(ignoringOtherApps: true)
	}

	@IBAction func swapButtonClicked(_ sender: NSButton) {
		let fromSelected = fromLangSegControl.selectedSegment
		let toSelected = toLangSegControl.selectedSegment
		fromLangSegControl.selectSegment(withTag: toSelected)
		toLangSegControl.selectSegment(withTag: fromSelected)
		(inputTextField.stringValue, outputTextField.stringValue) = (outputTextField.stringValue, inputTextField.stringValue)
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
		if fromLangSegControl.selectedSegment != fromLangSegControl.segmentCount - 1 && fromLangSegControl[fromLangSegControl.selectedSegment] ==  toLangSegControl[toLangSegControl.selectedSegment] {
			toLangSegControl.selectedSegment = (toLangSegControl.selectedSegment + 1) % toLangSegControl.segmentCount
		}
		guard fromLangSegControl.selectedSegment == fromLangSegControl.segmentCount - 1 && !inputTextField.isEmpty else {
			return
		}
		TranslateClient.shared.detectLanguage(byText: inputTextField.stringValue, completion: { lang in
			guard let lang = lang,
				let newLanguage = Languages.shared.searchLanguage(byShortName: lang) else {
					self.fromLangSegControl.detectedLanguage = nil
					return
			}
			self.fromLangSegControl.detectedLanguage = newLanguage
		})

	}

	@IBAction func toSegmentControlButton(_ sender: LanguagesSegmentControl) {
		while fromLangSegControl.selectedSegment != fromLangSegControl.segmentCount - 1 && fromLangSegControl[fromLangSegControl.selectedSegment] ==  toLangSegControl[toLangSegControl.selectedSegment] {
			fromLangSegControl.selectedSegment = (fromLangSegControl.selectedSegment + 1) % fromLangSegControl.segmentCount
		}
	}
}

extension TranslateViewController:  NSTextFieldDelegate {
	func switchHiddennessOutputTextField () {
		if(inputTextField.isEmpty && !TranslateViewController.isOutputTextFieldAlreadyHidden) {
			TranslateViewController.isOutputTextFieldAlreadyHidden = true
			outputTextField.isHidden = true
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
		var from: Language
		let to: Language = toLangSegControl[toLangSegControl.selectedSegment]
		if fromLangSegControl.selectedSegment != fromLangSegControl.segmentCount - 1 {
			from = fromLangSegControl[fromLangSegControl.selectedSegment]
		} else {
			from = fromLangSegControl.detectedLanguage!
		}
		TranslateClient.shared.translate(inputTextField.stringValue, from: from, to: to, completionHandler: { text in
			guard let text = text else {
				return
			}
			self.outputTextField.stringValue = text
		})
	}

	override func controlTextDidChange(_ obj: Notification) {
		switchHiddennessOutputTextField()
	}
}
