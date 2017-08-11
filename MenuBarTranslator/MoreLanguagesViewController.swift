//
//  MoreLanguagesViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 10.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class MoreLanguagesViewController: NSViewController {
    
//    var langsArray: Languages!

    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.columnAutoresizingStyle = NSTableViewColumnAutoresizingStyle.firstColumnOnlyAutoresizingStyle
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }
    
    func tableViewDoubleClick(_ sender:AnyObject) {

		guard 0..<Languages.shared.languages.count ~= tableView.selectedRow  else {
			return
		}
        
        // set a lang in segment control
    }
    
    
}

extension MoreLanguagesViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        var rows = 1
        while rows  < Languages.shared.languages.count {
            rows <<= 1
        }
//        return Int(sqrt(Double(rows)))
        return Languages.shared.languages.count
        
    }
    
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return Languages.shared.languages.count
    }
}


extension MoreLanguagesViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.make(withIdentifier: (tableColumn?.identifier)!, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = Languages.shared.languages[row].fullName
            return cell
        }
        return nil
    }
}


