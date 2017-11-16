//
//  TranslateViewController.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 28.07.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Cocoa
import AVFoundation

class TranslateViewController: NSViewController, AVAudioPlayerDelegate {
	@IBOutlet weak var yandexReferenceLabel: NSTextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		yandexReferenceSetup()
		
	}

	override func viewDidAppear() {
		super.viewDidAppear()
		NSApplication.shared.activate(ignoringOtherApps: true)
	}


}


