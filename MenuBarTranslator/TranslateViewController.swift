//
//  TranslateViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.07.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa


class TranslateViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var inputTextField: ResizableTextField!
    @IBOutlet weak var outputTextField: ResizableTextField!
    
    @IBOutlet weak var langsListPushButton: NSButton!
    @IBOutlet weak var detectLangPushButton: NSButton!
    @IBOutlet weak var fromLangSegControl: FromStandartLangsSegmentControl!
    @IBOutlet weak var toLangSegControl: ToStandartLangsSegmentControl!
    
    let langsPopover = NSPopover()
    
    
    static var isOutputTextFieldAlreadyHidden: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        outputTextField.isHidden = true
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
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
        guard fromLangSegControl.label(forSegment: fromLangSegControl.selectedSegment) != toLangSegControl.label(forSegment: toLangSegControl.selectedSegment) &&  inputTextField.stringValue.characters.count != 0 else {
            outputTextField.stringValue = inputTextField.stringValue
            return
        }
        let langDirection = "\(TranslateClient.langsMap[fromLangSegControl.label(forSegment: fromLangSegControl.selectedSegment)!]!)-\(TranslateClient.langsMap[toLangSegControl.label(forSegment: toLangSegControl.selectedSegment)!]!)"
        TranslateClient.shared.translateText(inputTextField.stringValue, toLanguage: langDirection, completionHandler: { text in
            guard let text = text else {
                return
            }
            self.outputTextField.stringValue = text
        })
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        switchHiddennessOutputTextField()
    }
    
    @IBAction func swapButtonClicked(_ sender: NSButton) {
        let fromSelected = fromLangSegControl.selectedSegment
        let toSelected = toLangSegControl.selectedSegment
        fromLangSegControl.selectSegment(withTag: toSelected)
        toLangSegControl.selectSegment(withTag: fromSelected)
        (inputTextField.stringValue, outputTextField.stringValue) = (outputTextField.stringValue, inputTextField.stringValue)
    }
    @IBAction func moreLanguagesButtonClicked(_ sender: NSButton) {
        langsPopover.behavior = NSPopoverBehavior.transient
        langsPopover.animates = true
        langsPopover.contentViewController = MoreLanguagesViewController(nibName: "MoreLanguagesViewController", bundle: nil)
        langsPopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
    }
    
    @IBAction func detectLangButtonClicked(_ sender: NSButton) {
        guard inputTextField.stringValue.characters.count != 0 else {
            return
        }
        TranslateClient.shared.detectLanguage(byText: inputTextField.stringValue, completion: { lang in
            guard let lang = lang else {
                return
            }
            for (key, value) in TranslateClient.langsMap {
                if value == lang {
                    self.detectLangPushButton.title = "\(key)(auto)"
                    return
                }
            }
            self.detectLangPushButton.title = "Error"
        })
        
    }
}
