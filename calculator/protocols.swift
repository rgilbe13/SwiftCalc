//
//  File.swift
//  calculator
//
//  Created by Rob Gilbert on 7/24/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import Foundation

protocol PCalculatorQueue {
    mutating func enqueue(newElement: String)
    mutating func dequeue() -> String
    mutating func clear()
    mutating func top() -> String
}

protocol PCalculatorStack {
    mutating func push(newElement: String)
    mutating func pop() -> String
    mutating func top() -> String
    mutating func count() -> Int
    mutating func clear()
}

