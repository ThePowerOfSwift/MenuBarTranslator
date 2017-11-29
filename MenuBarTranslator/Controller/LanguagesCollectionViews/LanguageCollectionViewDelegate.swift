//
//  LanguageCollectionViewDelegate.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 19.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

extension TranslateViewController: NSCollectionViewDelegate, RecentLanguageCollectionViewItemDelegate {
	func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
		guard indexPaths.count == 1,
			  let indexPath = indexPaths.first,
			  let item = collectionView.item(at: indexPath) as? LanguageCollectionViewItem,
			  let language = item.language,
			  let sender = languageView.activeButton else {
			return
		}
		guard !language.isAutoLanguage || sender != languageView.outputLanguageButton else { // output language can't be detected
			return
		}

		sender.language = language
		sender.state = .off

		if language.isAutoLanguage {
			detect()
		}

		recentLanguages.pushFront(language)
		recentLanguages = Array(recentLanguages.dropLast(max(0, recentLanguages.count - 3)))
		languagePicker.recentLanguages.reloadData()

		languagePicker.isHidden = true
		mainTranslateView.isHidden = false

		outputView.textView.isEmpty = true
	}

	func delete(item: RecentLanguageCollectionViewItem) {
		recentLanguages = recentLanguages.filter({ $0 != item.language! })
		languagePicker.recentLanguages.reloadData()
	}
}

