//
//  AllLanguagesViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 13.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa

extension CGPoint {
	static func ~=(point: CGPoint, rect: CGRect) -> Bool {
		return rect.origin.x...rect.origin.x + rect.size.width ~= point.x &&
			rect.origin.y...rect.origin.y + rect.size.height ~= point.y
	}
}

class AllLanguagesViewController: NSViewController {



	@IBOutlet weak var collectionView: NSCollectionView!
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.allowsMultipleSelection = false
		collectionView.allowsEmptySelection = false
	}

	override func viewDidAppear() {
		super.viewDidAppear()
		self.view.window?.acceptsMouseMovedEvents = true
	}

	override func mouseMoved(with event: NSEvent) {
		let eventPoint = event.locationInWindow
		let point = self.collectionView.convert(eventPoint, to: nil)
		let items = collectionView.visibleItems()
		for item in items {
			item.isSelected =  point ~= item.view.frame ? true : false
		}
	}
}

extension AllLanguagesViewController: NSCollectionViewDataSource {
	func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
		return Languages.shared.languages.count
	}

	func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
		let viewItem = collectionView.makeItem(withIdentifier: "LanguageCollectionViewItem", for: indexPath)
		guard let item = viewItem as? LanguageCollectionViewItem else {
			return viewItem
		}
		item.language = Languages.shared.languages[indexPath.item]
		return item
	}
}


extension AllLanguagesViewController: NSCollectionViewDelegate {

}
