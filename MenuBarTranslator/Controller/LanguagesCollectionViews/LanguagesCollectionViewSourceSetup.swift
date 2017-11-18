//
//  LanguagesCollectionViewSourceSetup.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 18.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa


extension TranslateViewController: NSCollectionViewDataSource {
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return languages.count
	}

	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		let viewItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LanguageCollectionViewItem"), for: indexPath)
		guard let item = viewItem as? LanguageCollectionViewItem else {
			return viewItem
		}
		item.language = languages[indexPath.item]
		return item
	}
}
