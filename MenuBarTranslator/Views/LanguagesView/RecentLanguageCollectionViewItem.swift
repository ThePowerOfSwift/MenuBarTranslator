//
//  RecentLanguageCollectionViewItem.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 19.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

protocol RecentLanguageCollectionViewItemDelegate {
    func delete(item: RecentLanguageCollectionViewItem)
}

class RecentLanguageCollectionViewItem: LanguageCollectionViewItem {

    @IBOutlet weak var closeButton: NSButton!

    var delegate: RecentLanguageCollectionViewItemDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeButtonClicked(_ sender: NSButton) {
        delegate?.delete(item: self)
    }
}
