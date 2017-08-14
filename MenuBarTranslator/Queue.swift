//
//  Queue.swift
//  MenuBarTranslator
//
//  Created by Artem Bobrov on 13.08.17.
//  Copyright © 2017 Artem Bobrov. All rights reserved.
//

import Foundation

class Queue <T>{
	var size: Int = 0
	internal var data = [T]()
	init() {
	}

	init(withAmount amount: Int) {
		size = amount
	}

	init(withArray array: Array<T>) {
		data = array
	}

	var isEmpty: Bool {
		return data.count == 0
	}

	var front: T? {
		return isEmpty ? nil : data[0]
	}

	func push(_ newElement: T) {
		data.append(newElement)
	}

	func pop() {
		data = Array(data.dropFirst(1))
	}

	func frontToTheEnd () -> T? {
		guard let value = front else {
			return nil
		}
		pop()
		push(value)
		print(data)
		return value
	}
}

class QueueInt: Queue<Int> {
	init(withInterval interval: CountableRange<Int>) {
		super.init()
		for idx in interval {
			super.push(idx)
		}
	}

	init(withInterval interval: CountableClosedRange<Int>) {
		super.init()
		for idx in interval {
			super.push(idx)
		}
	}
}
