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
    
    @IBOutlet weak var langsListPushButton: NSButton!
    @IBOutlet weak var fromLangSegControl: FromStandartLangsSegmentControl!
    @IBOutlet weak var toLangSegControl: ToStandartLangsSegmentControl!
    
    
    let langsPopover = NSPopover()
    static var isOutputTextFieldAlreadyHidden: Bool = true
	
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        outputTextField.isHidden = true
        
        langsPopover.behavior = NSPopoverBehavior.transient
        langsPopover.animates = true
        langsPopover.contentViewController = AllLanguagesViewController(nibName: "AllLanguagesViewController", bundle: nil)
        
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
    @IBAction func moreLanguagesButtonClicked(_ sender: NSButton) {
        langsPopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
    }
    
    @IBAction func fromSegmentControlButton(_ sender: FromStandartLangsSegmentControl) {
        if fromLangSegControl[fromLangSegControl.selectedSegment] ==  toLangSegControl[toLangSegControl.selectedSegment] {
            toLangSegControl.selectedSegment = (toLangSegControl.selectedSegment + 1) % toLangSegControl.segmentCount
        }
        guard fromLangSegControl.selectedSegment == 3 && inputTextField.stringValue.characters.count != 0 else {
            return
        }
        TranslateClient.shared.detectLanguage(byText: inputTextField.stringValue, completion: { lang in
            guard let lang = lang,
				let newLabel = Languages.shared.searchLanguage(byShortName: lang) else {
				self.fromLangSegControl[self.fromLangSegControl.selectedSegment] = "Error to detect"
                return
            }
			self.fromLangSegControl[self.fromLangSegControl.selectedSegment] = "\(newLabel)(auto)"
        })
        
    }
    
    @IBAction func toSegmentControlButton(_ sender: ToStandartLangsSegmentControl) {
		while fromLangSegControl[fromLangSegControl.selectedSegment] ==  toLangSegControl[toLangSegControl.selectedSegment] {
            fromLangSegControl.selectedSegment = (fromLangSegControl.selectedSegment + 1) % fromLangSegControl.segmentCount
        }
    }
}



extension TranslateViewController:  NSTextFieldDelegate {
	func switchHiddennessOutputTextField () {
		if(inputTextField.stringValue.characters.count == 0 && !TranslateViewController.isOutputTextFieldAlreadyHidden){
			TranslateViewController.isOutputTextFieldAlreadyHidden = true
			outputTextField.isHidden = true
		}
		else if (TranslateViewController.isOutputTextFieldAlreadyHidden){
			TranslateViewController.isOutputTextFieldAlreadyHidden = false
			outputTextField.isHidden = false
		}
	}

	override func controlTextDidEndEditing(_ obj: Notification) {
		guard fromLangSegControl[fromLangSegControl.selectedSegment] != toLangSegControl[toLangSegControl.selectedSegment] &&  inputTextField.stringValue.characters.count != 0 else {
			outputTextField.stringValue = inputTextField.stringValue
			return
		}
		if let fromFullLanguage = fromLangSegControl[fromLangSegControl.selectedSegment]?.characters.split(separator: " ").map(String.init)[0],
			let toFullLanguage = toLangSegControl[toLangSegControl.selectedSegment],
			let fromShortLanguage = Languages.shared.searchLanguage(byFullName: fromFullLanguage),
			let toShortLanguage = Languages.shared.searchLanguage(byFullName: toFullLanguage) {
			let langDirection = "\(fromShortLanguage)-\(toShortLanguage)"
			TranslateClient.shared.translateText(inputTextField.stringValue, byLanguageDirection: langDirection, completionHandler: { text in
				guard let text = text else {
					return
				}
				self.outputTextField.stringValue = text
			})
		}
	}

	override func controlTextDidChange(_ obj: Notification) {
		switchHiddennessOutputTextField()
	}
}
