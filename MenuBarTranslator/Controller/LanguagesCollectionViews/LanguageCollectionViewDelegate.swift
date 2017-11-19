//
//  LanguageCollectionViewDelegate.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 19.11.2017.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation
import Cocoa

extension TranslateViewController: NSCollectionViewDelegate {
	func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
		guard indexPaths.count == 1,
			let indexPath = indexPaths.first,
			let item = collectionView.item(at: indexPath) as? LanguageCollectionViewItem,
			let language = item.language else {
				return
		}
		guard language != Languages.auto || languageSender != outputLanguageButton else { // output language can't be detected
			return
		}

		languageSender?.language = language
		languageSender?.state = .off

		if language == Languages.auto {
			detect()
		}

		recentLanguages.pushFront(language)
		recentLanguages = Array(recentLanguages.dropLast(max(0, recentLanguages.count - 3)))
		languagePicker.recentLanguages.reloadData()

		languagePicker.isHidden = true
		mainTranslateView.isHidden = false
		self.updatePronounceLanguages()
		
		outputTextView.isEmpty = true
	}
}

