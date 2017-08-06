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
    
    static var isOutputTextFieldAlreadyHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        outputTextField.isHidden = true
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    func switchOutputTextField () {
        if(inputTextField.stringValue.characters.count == 0 && !TranslateViewController.isOutputTextFieldAlreadyHidden){
            TranslateViewController.isOutputTextFieldAlreadyHidden = true
            outputTextField.isHidden = true
        }
        else if (TranslateViewController.isOutputTextFieldAlreadyHidden){
            TranslateViewController.isOutputTextFieldAlreadyHidden = false
            outputTextField.isHidden = false
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        switchOutputTextField()
        if(inputTextField.stringValue.characters.count != 0){
            let translator = TranslateClient()
//            print("--Переведенный текст4: " + translator.translateText(inputTextField.stringValue, toLanguage: "ru"))
            outputTextField.stringValue = translator.translateText(inputTextField.stringValue, toLanguage: "ru")
        }
    }
    
}
