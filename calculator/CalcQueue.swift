//
//  CalcQueue.swift
//  calculator
//
//  Created by Rob Gilbert on 7/9/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import Foundation

/// A first-in/first-out queue of unconstrained size
/// - Complexity: push is O(1), pop is O(`count`)
public struct CalcQueue<Character>: ExpressibleByArrayLiteral {
    /// backing array store
    public private(set) var elements: Array<Character> = []
    
    /// introduce a new element to the queue in O(1) time
    public mutating func push(value: Character) { elements.append(value) }
    
    /// remove the front of the queue in O(`count` time
    public mutating func pop() -> Character { return elements.removeFirst() }
    
    /// test whether the queue is empty
    public var isEmpty: Bool { return elements.isEmpty }
    
    /// queue size, computed property
    public var count: Int { return elements.count }
    
    /// offer `ArrayLiteralConvertible` support
    public init(arrayLiteral elements: Character...) { self.elements = elements }
    
    public func indexAt(int: Int) -> Character {
        return elements[int]
    }
    
    public mutating func replaceAt(int: Int, char: Character) {
        elements[int] = char
    }
    
    public func unmatchedParentesis() -> Bool {
        var openCount:Int = 0
        var closedCount:Int = 0
        
        for i in 0...count-1 {
            if String(describing: elements[i]) == "(" { openCount += 1}
            if String(describing: elements[i]) == ")" {closedCount += 1}
        }
        
        if openCount > closedCount {
            return true
        } else {
            return false
        }
        
    }
}
