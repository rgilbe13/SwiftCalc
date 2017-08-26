//
//  CalcQueue.swift
//  calculator
//
//  Created by Rob Gilbert on 7/9/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import Foundation


public struct Queue: PCalculatorQueue {
    var elements = [String]()
    var isEmpty: Bool { return elements.isEmpty }
    
    mutating func enqueue(newElement: String) {
        elements.append(newElement)
    }
    
    mutating func dequeue() -> String {
        return elements.removeFirst()
    }
    
    mutating func clear() {
        elements.removeAll()
    }
    
    mutating func top() -> String {
        return elements.last!
    }
}
