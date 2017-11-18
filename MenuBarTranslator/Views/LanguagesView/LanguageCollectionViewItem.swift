//
//  LanguageCollectionViewItem.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 18.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class LanguageCollectionViewItem: NSCollectionViewItem {

	@IBOutlet weak var languageLabel: NSTextField!
	@IBOutlet weak var languageImage: NSImageView!

	var language: Language? {
		didSet {
			guard isViewLoaded, let language = language else {
				return
			}
			
			languageLabel.stringValue = language.fullName
			languageImage.image = language.image
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		view.wantsLayer = true
    }
    
}
