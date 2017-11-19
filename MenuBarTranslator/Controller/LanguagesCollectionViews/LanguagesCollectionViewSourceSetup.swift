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
		return collectionView == languagePicker.allLanguages ? languages.count: recentLanguages.count
	}

	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		if collectionView == languagePicker.allLanguages {
			let viewItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "LanguageCollectionViewItem"), for: indexPath)
			guard let item = viewItem as? LanguageCollectionViewItem else {
				return viewItem
			}
			item.language = languages[indexPath.item]
			return item
		}
		let viewItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "RecentLanguageCollectionViewItem"), for: indexPath)
		guard let item = viewItem as? RecentLanguageCollectionViewItem else {
			return viewItem
		}
		item.language = recentLanguages[indexPath.item]
		return item
	}

}
