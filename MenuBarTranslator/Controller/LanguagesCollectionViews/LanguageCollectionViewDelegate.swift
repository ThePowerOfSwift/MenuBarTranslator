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

		if !self.inputTextView.isEmpty && language == Languages.auto {
			print("detection")
			Dictionary.shared.detectLanguage(by: self.inputTextView.string, completion: { (lang) in
				guard let lang = lang else {
					return
				}
				self.languageSender?.language = Languages.searchLanguage(by: lang)
			})
		}

		recentLanguages.pushFront(language)
		recentLanguages = Array(recentLanguages.dropLast(max(0, recentLanguages.count - 3)))
		languagePicker.recentLanguages.reloadData()

		languagePicker.isHidden = true
		mainTranslateView.isHidden = false
		self.updatePronounceLanguages()

		if language != Languages.auto {
			inputTextView.isEmpty = true
		}
		outputTextView.isEmpty = true
	}



}

