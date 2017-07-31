//
//  TranslateViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.07.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class TranslateViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var inputTextField: NSTextField!
    @IBOutlet weak var outputTextField: NSTextField!
    
    var isOutputTextFieldAlreadyHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        outputTextField.isHidden = true
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    
    override func controlTextDidChange(_ obj: Notification) {
        if(inputTextField.stringValue.characters.count == 0 && !isOutputTextFieldAlreadyHidden){
            isOutputTextFieldAlreadyHidden = true
            outputTextField.isHidden = true
        }
        else if (isOutputTextFieldAlreadyHidden){
            isOutputTextFieldAlreadyHidden = false
            outputTextField.isHidden = false
        }
    }
}
