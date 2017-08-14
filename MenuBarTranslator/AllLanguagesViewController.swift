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
		let strangeConstant: CGFloat = 30.0
		return strangeConstant + rect.origin.x...strangeConstant + rect.origin.x + rect.width ~= point.x && rect.origin.y...rect.origin.y + rect.height ~= point.y
	}
}

class AllLanguagesViewController: NSViewController {

	@IBOutlet weak var collectionView: NSCollectionView!

	var languageSegmentControl: LanguagesSegmentControl!

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
		guard let items = collectionView.visibleItems() as? [LanguageCollectionViewItem] else{
			return
		}

		items.forEach({ $0.isChoosen = languageSegmentControl.values.contains($0.language!) })
	}

	override func mouseMoved(with event: NSEvent) {
		let eventPoint = event.locationInWindow
		let point = self.collectionView.convert(eventPoint, to: nil)
		guard let items = collectionView.visibleItems() as? [LanguageCollectionViewItem] else{
			return
		}
		items.forEach({$0.isHighlighted = point ~= $0.view.frame})
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
	func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
		guard indexPaths.count == 1,
			let indexPath = indexPaths.first,
			let item = collectionView.item(at: indexPath) as? LanguageCollectionViewItem else {
			return
		}
		guard let idx = languageSegmentControl.queue.frontToTheEnd(),
			let language = item.language,
			let items = collectionView.visibleItems() as? [LanguageCollectionViewItem] else {
			return
		}
		languageSegmentControl.values[idx] = language

		items.forEach({ $0.isChoosen = languageSegmentControl.values.contains($0.language!) })
		languageSegmentControl.selectedSegment = idx
		let appDelegate : AppDelegate = NSApplication.shared().delegate as! AppDelegate
		if let parentController = appDelegate.popover.contentViewController as? TranslateViewController {
			parentController.langsPopover.close()
		}

 	}
}
