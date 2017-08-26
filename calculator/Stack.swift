//
//  Stack.swift
//  calculator
//
//  Created by Rob Gilbert on 7/18/17.
//  Copyright © 2017 Rob Gilbert. All rights reserved.
//

import Foundation

struct Stack: PCalculatorStack {
    private var elements = [String]()
    var isEmpty: Bool { return elements.isEmpty }
    
    mutating func push(newElement: String) {
        elements.append(newElement)
    }
    
    mutating func pop() -> String {
        return elements.removeLast()
    }
    
    mutating func top() -> String {
        return elements.last!
    }
    
    mutating func count() -> Int {
        return elements.count
    }
    
    mutating func clear() {
        elements.removeAll()
    }
}
