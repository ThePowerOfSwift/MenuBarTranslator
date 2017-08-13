//
//  AllLanguagesViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 13.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class AllLanguagesViewController: NSViewController {

	@IBOutlet weak var collectionView: NSCollectionView!
	override func viewDidLoad() {
		super.viewDidLoad()
		//        collectionView.delegate = self
		collectionView.dataSource = self
	}
}


extension AllLanguagesViewController: NSCollectionViewDataSource {
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return Languages.shared.languages.count
	}

	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		let viewItem = collectionView.makeItem(withIdentifier: "LanguageCollectionViewItem", for: indexPath)
		guard let item = viewItem as? LanguageCollectionViewItem else {
			print("no", indexPath.section, indexPath.item)
			return viewItem
		}
		item.language = Languages.shared.languages[indexPath.item]

		return item
	}
}
