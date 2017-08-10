//
//  MoreLanguagesViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 10.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class MoreLanguagesViewController: NSViewController {
    var langsArray: [String]!
    
    @IBOutlet weak var languagesTableView: NSTableView!
    
    func numberOfRows(number: Int) -> Int{
        var index = 1
        while index  < number {
            index <<= 1
        }
        return index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        langsArray = Array(TranslateClient.langsMap.keys)
        print(numberOfRows(number: langsArray.count))
    }
    
    
    
}
