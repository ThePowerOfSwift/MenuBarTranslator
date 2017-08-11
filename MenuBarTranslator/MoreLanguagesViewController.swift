//
//  MoreLanguagesViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 10.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

class MoreLanguagesViewController: NSViewController {


	@IBOutlet weak var collectionView: NSCollectionView!
	
	var rowsColumns: Int {
		var rows = 1
		while rows  < Languages.shared.languages.count {
			rows <<= 1
		}
		return Int(sqrt(Double(rows)))
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
	func configureCollectionView() {
		let flowLayout = NSCollectionViewFlowLayout()
		flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
		flowLayout.sectionInset = EdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
		flowLayout.minimumInteritemSpacing = 20.0
		flowLayout.minimumLineSpacing = 20.0
		flowLayout.sectionHeadersPinToVisibleBounds = true
		collectionView.collectionViewLayout = flowLayout
		view.wantsLayer = true
		collectionView.layer?.backgroundColor = NSColor.black.cgColor
	}
}

extension MoreLanguagesViewController: NSCollectionViewDataSource {
	func numberOfSections(in collectionView: NSCollectionView) -> Int {
		return rowsColumns
	}


	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return rowsColumns
	}

	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		print(indexPath)
		let item = collectionView.makeItem(withIdentifier: "LanguageCollectionViewItem", for: indexPath)
		guard let collectionViewItem = item as? LanguageCollectionViewItem else {
			return item
		}

		let language = Languages.shared.languages[indexPath.section]
		collectionViewItem.language = language
		return item
	}

}


extension MoreLanguagesViewController: NSCollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
//		return NSSize(width: 1000, height: 40)
		return NSZeroSize
	}
}
